import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import '../../utils/distance.dart';

class QsoDetailScreen extends StatelessWidget {
  final LocalQso qso;

  const QsoDetailScreen({super.key, required this.qso});

  double? _parseCoord(String? coord) {
    if (coord == null || coord.isEmpty) return null;
    try {
      final direction = coord[0].toUpperCase();
      final parts = coord.substring(1).trim().split(' ');
      if (parts.length < 2) return null;
      
      final degrees = double.parse(parts[0]);
      final minutes = double.parse(parts[1]);
      
      double decimal = degrees + (minutes / 60.0);
      if (direction == 'S' || direction == 'W') {
        decimal = -decimal;
      }
      return decimal;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lat = _parseCoord(qso.lat);
    final lon = _parseCoord(qso.lon);
    final location = (lat != null && lon != null) ? LatLng(lat, lon) : null;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text('QSO DETAIL', style: theme.textTheme.labelMono.copyWith(fontWeight: FontWeight.bold, letterSpacing: 2)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              children: [
                _buildHeader(theme),
                const SizedBox(height: 16),
                
                if (location != null) ...[
                  _buildMapCard(location),
                  const SizedBox(height: 16),
                ],

                _buildBasicInfoCard(theme),
                const SizedBox(height: 16),
                
                _buildLocationCard(theme),
                const SizedBox(height: 16),

                if (qso.comment != null && qso.comment!.isNotEmpty) ...[
                  _buildCommentCard(theme),
                  const SizedBox(height: 16),
                ],

                _buildTechnicalFooter(theme),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(qso.callsign, style: theme.textTheme.displayLarge?.copyWith(fontSize: 24, color: AppTheme.primary, height: 1, overflow: TextOverflow.ellipsis)),
              Text(qso.name ?? 'Unknown Operator', style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.onSurfaceVariant, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
          ),
          child: Text(
            DateFormat('yyyy-MM-dd HH:mm').format(qso.qsoDate.toUtc()) + ' UTC',
            style: theme.textTheme.labelMono.copyWith(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildMapCard(LatLng location) {
    return InstrumentCard(
      padding: EdgeInsets.zero,
      accentColor: AppTheme.tertiary,
      child: SizedBox(
        height: 200,
        child: FlutterMap(
          options: MapOptions(
            initialCenter: location,
            initialZoom: 6,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.horizonqrz.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: AppTheme.error, size: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(theme, 'CONTACT SPECIFICATIONS'),
          const SizedBox(height: 16),
          _buildInfoGrid([
            _GridItem('BAND', qso.band),
            _GridItem('MODE', qso.mode),
            _GridItem('FREQ', formatFreq(qso.freq)),
          ], theme),
          Divider(height: 24),
          _buildInfoGrid([
            _GridItem('RST SENT', qso.rstSent ?? '--'),
            _GridItem('RST RCVD', qso.rstRcvd ?? '--'),
          ], theme),
        ],
      ),
    );
  }

  Widget _buildLocationCard(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(theme, 'LOCATION DATA'),
          const SizedBox(height: 16),
          _buildDetailRow('COUNTRY', qso.country ?? 'Unknown', theme),
          _buildDetailRow('QTH (CITY)', qso.qth ?? 'Unknown', theme),
          _buildDetailRow('GRID', qso.gridsquare ?? 'Unknown', theme),
          _buildDetailRow('LAT/LON', '${qso.lat ?? "N/A"} / ${qso.lon ?? "N/A"}', theme),
        ],
      ),
    );
  }

  Widget _buildCommentCard(ThemeData theme) {
    return InstrumentCard(
      accentColor: AppTheme.outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(theme, 'OPERATOR NOTES'),
          const SizedBox(height: 12),
          Text(
            qso.comment!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalFooter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('QRZ LOG ID', style: theme.textTheme.labelMono.copyWith(fontSize: 8, color: AppTheme.onSurfaceVariant)),
          Text(qso.supabaseId.isNotEmpty ? qso.supabaseId : 'PENDING SYNC', style: theme.textTheme.labelMono.copyWith(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.primary)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Row(
      children: [
        Container(width: 3, height: 12, color: AppTheme.primary),
        const SizedBox(width: 8),
        Text(title, style: theme.textTheme.labelLarge?.copyWith(fontSize: 8, letterSpacing: 1.5, color: AppTheme.primary)),
      ],
    );
  }

  Widget _buildInfoGrid(List<_GridItem> items, ThemeData theme) {
    return Row(
      children: items.map((item) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.label, style: theme.textTheme.labelMono.copyWith(fontSize: 7, color: AppTheme.onSurfaceVariant.withOpacity(0.7))),
            Text(item.value, style: theme.textTheme.labelMono.copyWith(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.labelMono.copyWith(fontSize: 8, color: AppTheme.onSurfaceVariant)),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _GridItem {
  final String label;
  final String value;
  _GridItem(this.label, this.value);
}

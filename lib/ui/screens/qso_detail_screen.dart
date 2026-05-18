import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import '../widgets/banner_ad_widget.dart';
import '../widgets/instrument_card.dart';

class QsoDetailScreen extends StatelessWidget {
  final Qso qso;

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
          const BannerAdWidget(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              children: [
                _buildHeader(theme),
                SizedBox(height: 2.h),
                
                if (location != null) ...[
                  _buildMapCard(location),
                  SizedBox(height: 2.h),
                ],

                _buildBasicInfoCard(theme),
                SizedBox(height: 2.h),
                
                _buildLocationCard(theme),
                SizedBox(height: 2.h),

                if (qso.comment != null && qso.comment!.isNotEmpty) ...[
                  _buildCommentCard(theme),
                  SizedBox(height: 2.h),
                ],

                _buildTechnicalFooter(theme),
                SizedBox(height: 4.h),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(qso.callsign, style: theme.textTheme.displayLarge?.copyWith(fontSize: 24.sp, color: AppTheme.primary, height: 1)),
            Text(qso.name ?? 'Unknown Operator', style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.onSurfaceVariant)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
          ),
          child: Text(
            DateFormat('yyyy-MM-dd HH:mm').format(qso.qsoDate.toUtc()) + ' UTC',
            style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold, color: AppTheme.primary),
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
        height: 25.h,
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
          SizedBox(height: 2.h),
          _buildInfoGrid([
            _GridItem('BAND', qso.band),
            _GridItem('MODE', qso.mode),
            _GridItem('FREQ', (qso.freq == null || qso.freq!.isEmpty) ? '--' : '${qso.freq} MHz'),
          ], theme),
          Divider(height: 3.h),
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
          SizedBox(height: 2.h),
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
          SizedBox(height: 1.5.h),
          Text(
            qso.comment!,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11.sp, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalFooter(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('QRZ LOG ID', style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, color: AppTheme.onSurfaceVariant)),
          Text(qso.qrzLogid ?? 'PENDING SYNC', style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold, color: AppTheme.primary)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Row(
      children: [
        Container(width: 3, height: 12, color: AppTheme.primary),
        SizedBox(width: 2.w),
        Text(title, style: theme.textTheme.labelLarge?.copyWith(fontSize: 8.sp, letterSpacing: 1.5, color: AppTheme.primary)),
      ],
    );
  }

  Widget _buildInfoGrid(List<_GridItem> items, ThemeData theme) {
    return Row(
      children: items.map((item) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.label, style: theme.textTheme.labelMono.copyWith(fontSize: 7.sp, color: AppTheme.onSurfaceVariant.withOpacity(0.7))),
            Text(item.value, style: theme.textTheme.labelMono.copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold, color: AppTheme.onSurface)),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildDetailRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, color: AppTheme.onSurfaceVariant)),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w600)),
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

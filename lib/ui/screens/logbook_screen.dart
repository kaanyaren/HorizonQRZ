import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import 'qso_detail_screen.dart';
import '../../utils/distance.dart';

class LogbookScreen extends ConsumerStatefulWidget {
  const LogbookScreen({super.key});

  @override
  ConsumerState<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends ConsumerState<LogbookScreen> {
  String _searchQuery = '';
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('LOGBOOK'),
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
        // Search & Filter Bar (Pinned)
        SliverPersistentHeader(
          pinned: true,
          delegate: _SearchHeaderDelegate(
            child: Container(
              color: theme.scaffoldBackgroundColor.withOpacity(0.95),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: AppTheme.outlineVariant,
                    width: 1.2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        style: theme.textTheme.labelMono.copyWith(
                          fontSize: 11,
                          color: AppTheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search Callsign...',
                          hintStyle: GoogleFonts.spaceGrotesk(
                            fontSize: 11,
                            color: AppTheme.outline,
                          ),
                          filled: false,
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 14, color: AppTheme.outline),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Log List
        StreamBuilder<List<LocalQso>>(
          stream: (db.select(db.localQsos)
                ..where((t) => t.callsign.contains(_searchQuery.toUpperCase()))
                ..orderBy([(t) => drift.OrderingTerm.desc(t.qsoDate)]))
              .watch(),
          builder: (context, snapshot) {
            final qsos = snapshot.data ?? [];

            if (qsos.isEmpty && snapshot.connectionState == ConnectionState.active) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open_rounded,
                          size: 48,
                          color: AppTheme.outline.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No entries found',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching for another callsign or log a new QSO.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index >= qsos.length) return null;
                    final qso = qsos[index];
                    
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => QsoDetailScreen(qso: qso),
                        ),
                      ),
                      child: _buildLogEntry(context, qso),
                    );
                  },
                  childCount: qsos.length,
                ),
              ),
            );
          },
        ),
        
        SliverToBoxAdapter(child: const SizedBox(height: 96)),
      ],
    ),
  );
}

  Color _bandColor(String band) {
    switch (band.toUpperCase()) {
      case '160M': return const Color(0xFF8B5CF6); // Rich Violet
      case '80M': return const Color(0xFF3B82F6); // Vibrant Blue
      case '60M': return const Color(0xFF06B6D4); // Cyan
      case '40M': return const Color(0xFF10B981); // Emerald
      case '30M': return const Color(0xFF84CC16); // Lime
      case '20M': return const Color(0xFFEAB308); // Yellow
      case '17M': return const Color(0xFFF97316); // Orange
      case '15M': return const Color(0xFFEF4444); // Red
      case '12M': return const Color(0xFFEC4899); // Pink
      case '10M': return const Color(0xFFD946EF); // Fuchsia
      case '6M': return const Color(0xFF6366F1); // Indigo
      case '2M': return const Color(0xFF14B8A6); // Teal
      case '70CM': return const Color(0xFFF43F5E); // Rose
      default: return AppTheme.outline;
    }
  }

  Color _modeColor(String mode) {
    switch (mode.toUpperCase()) {
      case 'SSB': return const Color(0xFF0EA5E9); // Sky Blue
      case 'CW': return const Color(0xFF4F46E5); // Vibrant Indigo
      case 'FT8': return const Color(0xFFD946EF); // Fuchsia
      case 'FT4': return const Color(0xFFEC4899); // Pink
      case 'FM': return const Color(0xFF10B981); // Emerald
      case 'AM': return const Color(0xFFF59E0B); // Amber
      case 'RTTY': return const Color(0xFF8B5CF6); // Purple
      default: return AppTheme.outline;
    }
  }

  Widget _buildLogEntry(BuildContext context, LocalQso qso) {
    final theme = Theme.of(context);
    final freq = (qso.freq == null || qso.freq!.isEmpty) ? '-' : qso.freq!;
    final locState = ref.watch(locationProvider);
    String distance = '-';
    if (locState.latitude != null && locState.longitude != null) {
      final dxLat = parseCoord(qso.lat);
      final dxLon = parseCoord(qso.lon);
      if (dxLat != null && dxLon != null) {
        distance = formatDistance(haversine(locState.latitude!, locState.longitude!, dxLat, dxLon));
      }
    }

    final accent = _bandColor(qso.band);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: accent.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppTheme.outlineVariant,
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left color indicator bar representing the band
            Container(
              width: 5,
              color: accent,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                qso.callsign,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                                  color: AppTheme.onSurface,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              if (qso.name != null && qso.name!.isNotEmpty) ...[
                                const SizedBox(height: 3),
                                Text(
                                  qso.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppTheme.onSurfaceVariant,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${DateFormat('yyyy-MM-dd HH:mm').format(qso.qsoDate)} UTC',
                              style: theme.textTheme.labelMono.copyWith(
                                fontSize: 8.5,
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                            if (distance != '-') ...[
                              const SizedBox(height: 3),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.navigation_outlined, size: 8.5, color: AppTheme.secondary),
                                  const SizedBox(width: 2),
                                  Text(
                                    distance,
                                    style: theme.textTheme.labelMono.copyWith(
                                      fontSize: 8,
                                      color: AppTheme.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Frequency Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppTheme.outlineVariant, width: 1),
                          ),
                          child: Text(
                            '$freq MHz',
                            style: theme.textTheme.labelMono.copyWith(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                          ),
                        ),
                        const Spacer(),
                        _buildPill(context, qso.band.toUpperCase(), _bandColor(qso.band)),
                        const SizedBox(width: 6),
                        _buildPill(context, qso.mode.toUpperCase(), _modeColor(qso.mode)),
                        const SizedBox(width: 8),
                        // Verification/Sync state icon
                        Tooltip(
                          message: 'Logged Successfully',
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppTheme.tertiaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: AppTheme.onTertiaryContainer,
                              size: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(BuildContext context, String text, Color baseColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: baseColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelMono.copyWith(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: baseColor,
        ),
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _SearchHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => 88;
  @override
  double get minExtent => 88;

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => true;
}



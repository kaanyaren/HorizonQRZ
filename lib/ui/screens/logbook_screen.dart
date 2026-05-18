import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:sizer/sizer.dart';
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import 'qso_detail_screen.dart';

class LogbookScreen extends ConsumerStatefulWidget {
  const LogbookScreen({super.key});

  @override
  ConsumerState<LogbookScreen> createState() => _LogbookScreenState();
}

class _LogbookScreenState extends ConsumerState<LogbookScreen> {
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
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
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(4.w, 6.h, 4.w, 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HorizonQRZ',
                    style: theme.textTheme.displayLarge?.copyWith(fontSize: 18.sp),
                  ),
                  IconButton(
                    icon: Icon(Icons.sync, color: AppTheme.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),

          // Search & Filter Bar (Pinned)
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchHeaderDelegate(
              child: Container(
                color: theme.colorScheme.surface,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: InstrumentCard(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 16.sp, color: AppTheme.onSurfaceVariant),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: TextField(
                          onChanged: _onSearchChanged,
                          style: theme.textTheme.labelMono.copyWith(fontSize: 10.sp),
                          decoration: const InputDecoration(
                            hintText: 'Search Callsign...',
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Log List
          StreamBuilder<List<Qso>>(
            stream: (db.select(db.qsos)
                  ..where((t) => t.callsign.contains(_searchQuery.toUpperCase()))
                  ..orderBy([(t) => drift.OrderingTerm.desc(t.qsoDate)]))
                .watch(),
            builder: (context, snapshot) {
              final qsos = snapshot.data ?? [];

              if (qsos.isEmpty && snapshot.connectionState == ConnectionState.active) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: const Text('No entries found'),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= qsos.length) return null;
                      final qso = qsos[index];
                      final isFirst = index == 0;
                      final isLast = index == qsos.length - 1;
                      
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => QsoDetailScreen(qso: qso),
                              ),
                            ),
                            child: _buildLogEntry(context, qso, index % 2 != 0, isFirst: isFirst, isLast: isLast),
                          ),
                          if (!isLast) const Divider(height: 1, color: AppTheme.outlineVariant),
                        ],
                      );
                    },
                    childCount: qsos.length,
                  ),
                ),
              );
            },
          ),
          
          SliverToBoxAdapter(child: SizedBox(height: 4.h)),
        ],
      ),
    );
  }

  Widget _buildLogEntry(BuildContext context, Qso qso, bool alternate, {bool isFirst = false, bool isLast = false}) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: alternate ? AppTheme.surfaceContainerLow.withOpacity(0.9) : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(4.w) : Radius.zero,
          bottom: isLast ? Radius.circular(4.w) : Radius.zero,
        ),
        border: Border.symmetric(
          vertical: const BorderSide(color: AppTheme.outlineVariant),
          horizontal: isFirst || isLast ? const BorderSide(color: AppTheme.outlineVariant) : BorderSide.none,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(qso.callsign, style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    )),
                    Text(DateFormat('yy-MM-dd HH:mm').format(qso.qsoDate), 
                      style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp, color: AppTheme.onSurfaceVariant)),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Text((qso.freq == null || qso.freq!.isEmpty) ? '-' : qso.freq!, style: theme.textTheme.labelMono.copyWith(fontSize: 9.sp)),
                    SizedBox(width: 2.w),
                    _buildTag(context, qso.band.toUpperCase()),
                    SizedBox(width: 1.w),
                    _buildTag(context, qso.mode.toUpperCase()),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.check_circle, color: AppTheme.tertiaryContainer, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.2.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant,
        borderRadius: BorderRadius.circular(3.w),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontSize: 7.sp,
        color: AppTheme.onSurfaceVariant,
      )),
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
  double get maxExtent => 10.h;
  @override
  double get minExtent => 10.h;

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => false;
}


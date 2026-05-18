import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../providers/app_providers.dart';
import '../../providers/sync_provider.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import '../../database/app_database.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _syncAnimController;

  final GlobalKey _syncKey = GlobalKey();
  final GlobalKey _statsKey = GlobalKey();
  final GlobalKey _logKey = GlobalKey();
  final GlobalKey _latestKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _syncAnimController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _isFirstLaunch());
  }

  @override
  void dispose() {
    _syncAnimController.dispose();
    super.dispose();
  }

  Future<void> _isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isDone = prefs.getBool('showcase_done') ?? false;

    if (!isDone) {
      if (mounted) {
        ShowCaseWidget.of(context).startShowCase([_syncKey, _statsKey, _logKey, _latestKey]);
        await prefs.setBool('showcase_done', true);
      }
    }
  }

  Future<Map<String, String>> _fetchStatus() async {
    final db = ref.read(databaseProvider);
    final logbookService = ref.read(qrzLogbookServiceProvider);

    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings?.logbookApiKey == null) return {};

    return await logbookService.getStatus(settings!.logbookApiKey!);
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    final theme = Theme.of(context);
    final isMobile = SizerUtil.deviceType == DeviceType.mobile;

    ref.listen<SyncState>(syncProvider, (_, next) {
      final active = next.phase == SyncPhase.fetching ||
          next.phase == SyncPhase.parsing ||
          next.phase == SyncPhase.syncing;
      if (active) {
        _syncAnimController.repeat();
      } else {
        _syncAnimController.stop();
        _syncAnimController.reset();
      }
    });

    return Scaffold(
      body: FutureBuilder<Map<String, String>>(
        future: _fetchStatus(),
        builder: (context, snapshot) {
          final stats = snapshot.data ?? {};

          return StreamBuilder<List<Qso>>(
            stream: (db.select(db.qsos)..orderBy([(t) => drift.OrderingTerm.desc(t.qsoDate)])..limit(10)).watch(),
            builder: (context, qsoSnapshot) {
              final recentQsos = qsoSnapshot.data ?? [];
              final latestQso = recentQsos.isNotEmpty ? recentQsos.first : null;

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: ListView(
                  padding: EdgeInsets.all(isMobile ? 4.w : 2.w),
                  children: [
                    SizedBox(height: isMobile ? 4.h : 2.h),
                    // Branding Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'HorizonQRZ',
                          style: theme.textTheme.displayLarge?.copyWith(fontSize: 18.sp),
                        ),
                        Showcase(
                          key: _syncKey,
                          description: 'Sync your logs with QRZ.com anytime.',
                          child: IconButton(
                            icon: RotationTransition(
                              turns: _syncAnimController,
                              child: const Icon(Icons.sync, color: AppTheme.primary),
                            ),
                            onPressed: () => ref.read(syncProvider.notifier).fetchAndSyncAllLogs(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    // Horizontal Stats Row
                    Showcase(
                      key: _statsKey,
                      description: 'Track your total QSOs, DXCC entities, and confirmations.',
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.center,
                          children: [
                            _buildStatCard('Total QSOs', stats['qso_count'] ?? '0', isMobile),
                            SizedBox(width: 3.w),
                            _buildStatCard('Countries', stats['dxcc_count'] ?? '0', isMobile),
                            SizedBox(width: 3.w),
                            _buildStatCard('Confirmed', stats['confirmed_count'] ?? '0', isMobile),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // New: Latest Logged & Activity Row (Equal Heights)
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _buildLatestLoggedCard(theme, latestQso),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            flex: 5,
                            child: _buildActivityCard(theme),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),

                    // Live Action Panel
                    _buildLiveActionPanel(theme, recentQsos),
                    SizedBox(height: 3.h),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLiveActionPanel(ThemeData theme, List<Qso> recentQsos) {
    return InstrumentCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            child: Row(
              children: [
                Icon(Icons.sensors, color: AppTheme.tertiary, size: 12.sp),
                SizedBox(width: 2.w),
                Text('LIVE ACTION', style: theme.textTheme.headlineSmall?.copyWith(fontSize: 12.sp)),
                const Spacer(),
                Showcase(
                  key: _logKey,
                  description: 'Quickly log a new contact on the fly.',
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ref.read(navigationProvider.notifier).setTab(1);
                    },
                    icon: Icon(Icons.add, size: 10.sp),
                    label: const Text('QUICK LOG'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0),
                      minimumSize: Size(0, 4.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.outlineVariant),
          _buildLogTable(context, recentQsos),
        ],
      ),
    );
  }

  Widget _buildLatestLoggedCard(ThemeData theme, Qso? latestQso) {
    return Showcase(
      key: _latestKey,
      description: 'View details of your most recent contact.',
      child: InstrumentCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LATEST LOGGED', style: theme.textTheme.labelLarge),
            SizedBox(height: 1.h),
            Text(latestQso?.callsign ?? 'N/A', 
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 22.sp, color: AppTheme.primary)),
            SizedBox(height: 1.5.h),
            if (latestQso != null) ...[
              Row(
                children: [
                  _buildTag(latestQso.band),
                  SizedBox(width: 2.w),
                  _buildTag(latestQso.mode),
                ],
              ),
              SizedBox(height: 1.h),
              Text('${(latestQso.freq != null && latestQso.freq!.isNotEmpty) ? "${latestQso.freq} MHz • " : ""}${DateFormat('HH:mm').format(latestQso.qsoDate)}Z',
                style: theme.textTheme.labelMono.copyWith(color: AppTheme.onSurfaceVariant)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(ThemeData theme) {
    return InstrumentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACTIVITY (LAST 12H)', style: theme.textTheme.labelLarge),
          SizedBox(height: 2.h),
          SizedBox(
            height: 10.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                final isCurrent = index == 11;
                final h = (0.2 + (index * 0.05) + (isCurrent ? 0.3 : 0)).clamp(0.1, 1.0);
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isCurrent ? AppTheme.tertiary : AppTheme.surfaceVariant,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                    height: 10.h * h,
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('-12h', style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp)),
              Text('Now', style: theme.textTheme.labelMono.copyWith(fontSize: 8.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, bool isMobile) {
    return Container(
      width: isMobile ? 30.w : 20.w,
      padding: EdgeInsets.all(isMobile ? 3.w : 1.5.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest.withOpacity(0.9),
        borderRadius: BorderRadius.circular(isMobile ? 3.w : 1.w),
        border: const Border(top: BorderSide(color: AppTheme.primary, width: 3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 7.sp, color: AppTheme.onSurfaceVariant)),
          SizedBox(height: 0.5.h),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary, fontSize: 16.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }


  Widget _buildLogTable(BuildContext context, List<Qso> qsos) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: IntrinsicColumnWidth(),
        3: IntrinsicColumnWidth(),
        4: IntrinsicColumnWidth(),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppTheme.surfaceContainerHigh),
          children: [
            _buildTableHeader('TIME (UTC)'),
            _buildTableHeader('CALLSIGN'),
            _buildTableHeader('FREQ'),
            _buildTableHeader('MODE'),
            _buildTableHeader('RST S/R'),
          ],
        ),
        ...qsos.map((qso) => TableRow(
          decoration: BoxDecoration(
            color: qsos.indexOf(qso) % 2 == 0 ? AppTheme.surfaceContainerLowest : AppTheme.surfaceContainerLow,
            border: const Border(bottom: BorderSide(color: AppTheme.outlineVariant)),
          ),
          children: [
            _buildTableCell(DateFormat('HH:mm:ss').format(qso.qsoDate), color: AppTheme.onSurfaceVariant),
            _buildTableCell(qso.callsign, bold: true, color: AppTheme.primary),
            _buildTableCell((qso.freq == null || qso.freq!.isEmpty) ? '-' : qso.freq!),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
              child: _buildTag(qso.mode, compact: true),
            ),
            _buildTableCell('${qso.rstSent ?? ""}/${qso.rstRcvd ?? ""}'),
          ],
        )),
        if (qsos.isEmpty)
          TableRow(children: List.generate(5, (_) => Padding(padding: EdgeInsets.all(4.w), child: const Text('No data')))),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 8.sp)),
    );
  }

  Widget _buildTableCell(String text, {bool bold = false, Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 2.w),
      child: Text(text, style: Theme.of(context).textTheme.labelMono.copyWith(
        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        color: color,
        fontSize: 9.sp,
      )),
    );
  }

  Widget _buildTag(String text, {bool compact = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 1.w : 2.w, vertical: compact ? 0.2.h : 0.5.h),
      decoration: BoxDecoration(color: AppTheme.surfaceVariant, borderRadius: BorderRadius.circular(3.w)),
      child: Text(text, style: Theme.of(context).textTheme.labelMono.copyWith(
        fontSize: compact ? 7.sp : 8.sp,
        color: AppTheme.onSurfaceVariant,
      )),
    );
  }
}

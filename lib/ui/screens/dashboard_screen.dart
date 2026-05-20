import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import 'package:showcaseview/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../providers/app_providers.dart';
import '../../providers/upload_provider.dart';
import '../../providers/sync_state_provider.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';
import '../../database/app_database.dart';

const _secureStorage = FlutterSecureStorage();

Future<String?> _getQrzApiKey(AppDatabase db) async {
  final secureKey = await _secureStorage.read(key: 'qrz_logbook_api_key');
  if (secureKey != null && secureKey.isNotEmpty) return secureKey;
  final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
  return settings?.logbookApiKey;
}

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
        ShowCaseWidget.of(context).startShowCase([_syncKey, _statsKey, _latestKey]);
        await prefs.setBool('showcase_done', true);
      }
    }
  }

  Future<Map<String, String>> _fetchStatus() async {
    final db = ref.read(databaseProvider);
    final logbookService = ref.read(qrzLogbookServiceProvider);

    final apiKey = await _getQrzApiKey(db);
    if (apiKey == null) return {};

    return await logbookService.getStatus(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(databaseProvider);
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    ref.listen<AppSyncState>(appSyncProvider, (_, next) {
      final active = next.phase == AppSyncPhase.syncing ||
          next.phase == AppSyncPhase.pushing ||
          next.phase == AppSyncPhase.pulling;
      if (active) {
        _syncAnimController.repeat();
      } else {
        _syncAnimController.stop();
        _syncAnimController.reset();
      }
    });

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('HORIZON QRZ'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Showcase(
            key: _syncKey,
            description: 'Sync your logs with QRZ.com anytime.',
            child: IconButton(
              icon: RotationTransition(
                turns: _syncAnimController,
                child: const Icon(Icons.sync_rounded),
              ),
              onPressed: () async {
                ref.read(uploadProvider.notifier).startUpload();
                ref.read(appSyncProvider.notifier).syncAll();
                
                // Also trigger QRZ Import
                final db = ref.read(databaseProvider);
                final apiKey = await _getQrzApiKey(db);
                if (apiKey != null) {
                  ref.read(qrzImportServiceProvider).importFromQrz(apiKey);
                }
              },
              tooltip: 'Sync Logbooks',
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchStatus(),
        builder: (context, snapshot) {
          final stats = snapshot.data ?? {};

          return StreamBuilder<List<LocalQso>>(
            stream: (db.select(db.localQsos)..orderBy([(t) => drift.OrderingTerm.desc(t.qsoDate)])..limit(10)).watch(),
            builder: (context, qsoSnapshot) {
              final recentQsos = qsoSnapshot.data ?? [];
              final latestQso = recentQsos.isNotEmpty ? recentQsos.first : null;

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(isMobile ? 16.0 : 8.0, 16.0, isMobile ? 16.0 : 8.0, 96),
                  children: [
                    const SizedBox(height: 8.0),
                    // Horizontal Stats Row
                    Showcase(
                      key: _statsKey,
                      description: 'Track your total QSOs, DXCC entities, and confirmations.',
                      child: Row(
                        children: [
                          Expanded(child: _buildStatCard('Total QSOs', stats['qso_count'] ?? '0', isMobile)),
                          const SizedBox(width: 8.0),
                          Expanded(child: _buildStatCard('Countries', stats['dxcc_count'] ?? '0', isMobile)),
                          const SizedBox(width: 8.0),
                          Expanded(child: _buildStatCard('Confirmed', stats['confirmed_count'] ?? '0', isMobile)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // New: Latest Logged & Activity Row (Equal Heights)
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _buildLatestLoggedCard(theme, latestQso),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            flex: 5,
                            child: _buildActivityCard(theme),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLatestLoggedCard(ThemeData theme, LocalQso? latestQso) {
    return Showcase(
      key: _latestKey,
      description: 'View details of your most recent contact.',
      child: InstrumentCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LATEST LOGGED', style: theme.textTheme.labelLarge),
            const SizedBox(height: 8.0),
            Text(latestQso?.callsign ?? 'N/A', 
              style: theme.textTheme.displayLarge?.copyWith(fontSize: 22.0, color: AppTheme.primary)),
            const SizedBox(height: 12.0),
            if (latestQso != null) ...[
              Row(
                children: [
                  _buildTag(latestQso.band),
                  const SizedBox(width: 8.0),
                  _buildTag(latestQso.mode),
                ],
              ),
              const SizedBox(height: 8.0),
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
          const SizedBox(height: 16.0),
          SizedBox(
            height: 80.0,
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
                    height: 80.0 * h,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('-12h', style: theme.textTheme.labelMono.copyWith(fontSize: 10.0)),
              Text('Now', style: theme.textTheme.labelMono.copyWith(fontSize: 10.0)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12.0 : 8.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(isMobile ? 12.0 : 8.0),
        border: const Border(top: BorderSide(color: AppTheme.primary, width: 3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 9.0, color: AppTheme.onSurfaceVariant), overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4.0),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppTheme.primary, fontSize: 16.0, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  Widget _buildTag(String text, {bool compact = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 4.0 : 8.0, vertical: compact ? 2.0 : 4.0),
      decoration: BoxDecoration(color: AppTheme.surfaceVariant, borderRadius: BorderRadius.circular(12.0)),
      child: Text(text, style: Theme.of(context).textTheme.labelMono.copyWith(
        fontSize: compact ? 9.0 : 10.0,
        color: AppTheme.onSurfaceVariant,
      )),
    );
  }
}


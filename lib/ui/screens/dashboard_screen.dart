import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';
import '../../utils/adif_parser.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  Map<String, int>? _bandStats;
  Map<String, int>? _modeStats;
  bool _isSyncingDetailed = false;

  Future<Map<String, String>> _fetchStatus() async {
    final db = ref.read(databaseProvider);
    final logbookService = ref.read(qrzLogbookServiceProvider);
    
    final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
    if (settings?.logbookApiKey == null) throw Exception('API Key not found');

    return await logbookService.getStatus(settings!.logbookApiKey!);
  }

  Future<void> _fetchDetailedStats() async {
    setState(() => _isSyncingDetailed = true);
    try {
      final db = ref.read(databaseProvider);
      final logbookService = ref.read(qrzLogbookServiceProvider);
      final settings = await (db.select(db.appSettings)..limit(1)).getSingleOrNull();
      
      final adif = await logbookService.extractLog(settings!.logbookApiKey!);
      
      setState(() {
        _bandStats = AdifParser.countByField(adif, 'BAND');
        _modeStats = AdifParser.countByField(adif, 'MODE');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => _isSyncingDetailed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: _isSyncingDetailed 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.analytics),
            onPressed: _isSyncingDetailed ? null : _fetchDetailedStats,
            tooltip: 'Fetch Detailed Stats',
          ),
        ],
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _fetchStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final qsoCount = data['qso_count'] ?? '0';
          final dxccCount = data['dxcc_count'] ?? '0';
          final confirmedCount = data['confirmed_count'] ?? '0';

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildStatCard(context, 'Total QSOs', qsoCount, Icons.history),
                const SizedBox(height: 16),
                _buildStatCard(context, 'DXCC Entities', dxccCount, Icons.public),
                const SizedBox(height: 16),
                _buildStatCard(context, 'Confirmed', confirmedCount, Icons.check_circle),
                const SizedBox(height: 32),
                const Text(
                  'Awards Progress',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildAwardTile('DX Century Club', dxccCount, '100'),
                _buildAwardTile('Worked All States', '0', '50'),
                if (_bandStats != null) ...[
                  const SizedBox(height: 32),
                  const Text('Stats by Band', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _bandStats!.entries.map((e) => Chip(label: Text('${e.key}: ${e.value}'))).toList(),
                  ),
                ],
                if (_modeStats != null) ...[
                  const SizedBox(height: 24),
                  const Text('Stats by Mode', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _modeStats!.entries.map((e) => Chip(label: Text('${e.key}: ${e.value}'))).toList(),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardTile(String title, String current, String target) {
    final progress = double.tryParse(current) ?? 0;
    final max = double.tryParse(target) ?? 100;
    final percent = (progress / max).clamp(0.0, 1.0);

    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text('$current / $target'),
        ),
        LinearProgressIndicator(value: percent),
        const SizedBox(height: 16),
      ],
    );
  }
}

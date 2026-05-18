import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' hide Column;
import '../../providers/app_providers.dart';
import '../../providers/sync_provider.dart';
import '../../database/app_database.dart';

class LogbookScreen extends ConsumerWidget {
  const LogbookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logbook'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Syncing with QRZ...')),
              );
              await ref.read(syncProvider).syncPendingQsos();
              await ref.read(syncProvider).fetchAndSyncAllLogs();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sync Complete')),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Qso>>(
        stream: (db.select(db.qsos)..orderBy([(t) => OrderingTerm.desc(t.qsoDate)])).watch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final qsos = snapshot.data!;
          if (qsos.isEmpty) {
            return const Center(child: Text('No QSOs logged yet.'));
          }

          return ListView.separated(
            itemCount: qsos.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final qso = qsos[index];
              return ListTile(
                title: Text(qso.callsign, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${DateFormat('yyyy-MM-dd HH:mm').format(qso.qsoDate)} UTC'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${qso.band} / ${qso.mode}'),
                    _buildSyncStatus(qso.syncStatus),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSyncStatus(String status) {
    IconData icon;
    Color color;
    switch (status) {
      case 'synced':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'error':
        icon = Icons.error;
        color = Colors.red;
        break;
      default:
        icon = Icons.cloud_upload;
        color = Colors.orange;
    }
    return Icon(icon, size: 16, color: color);
  }
}

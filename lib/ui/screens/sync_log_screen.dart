import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../providers/app_providers.dart';
import '../../database/app_database.dart';
import '../theme.dart';
import 'package:intl/intl.dart';

class SyncLogScreen extends ConsumerWidget {
  const SyncLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILED SYNC LOG'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await db.delete(db.syncLogs).go();
            },
          ),
        ],
      ),
      body: StreamBuilder<List<SyncLog>>(
        stream: (db.select(db.syncLogs)
              ..orderBy([(t) => drift.OrderingTerm(expression: t.timestamp, mode: drift.OrderingMode.desc)]))
            .watch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final logs = snapshot.data!;
          if (logs.isEmpty) {
            return const Center(child: Text('No sync logs yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: logs.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final log = logs[index];
              final isError = log.level == 'error';
              
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                leading: Icon(
                  isError ? Icons.error_outline : Icons.info_outline,
                  color: isError ? theme.colorScheme.error : theme.colorScheme.primary,
                ),
                title: Text(
                  log.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isError ? theme.colorScheme.error : null,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(log.timestamp),
                      style: theme.textTheme.bodySmall,
                    ),
                    if (log.details != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        log.details!,
                        style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'monospace'),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

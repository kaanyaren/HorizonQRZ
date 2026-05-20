import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../providers/awards_provider.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';

class AwardData {
  final String title;
  final String subtitle;
  final int current;
  final int total;
  final Color accent;
  final bool completed;
  final String unitLabel;
  final List<String> stats;
  final List<String> labels;

  const AwardData({
    required this.title,
    required this.subtitle,
    required this.current,
    required this.total,
    required this.accent,
    required this.completed,
    required this.unitLabel,
    required this.stats,
    required this.labels,
  });
}

class AwardsScreen extends ConsumerWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final awardsCount = ref.watch(awardsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: awardsCount == 0
            ? const Center(child: Text('No awards data available'))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 8),
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'AWARDS GALLERY',
                    style: theme.textTheme.displayLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 32),
                ],
              ),
      ),
    );
  }

  Widget _buildAwardCard(BuildContext context, AwardData award, bool isMobile) {
    final theme = Theme.of(context);
    final progress = (award.current / award.total).clamp(0.0, 1.0);

    return InstrumentCard(
      accentColor: award.accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      award.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      award.subtitle,
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 7),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: award.completed ? AppTheme.tertiary : AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(isMobile ? 8 : 4),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Text(
                  award.completed ? 'COMPLETED' : 'ACTIVE',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: 7,
                    color: award.completed ? Colors.white : AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(award.unitLabel, style: theme.textTheme.labelLarge?.copyWith(fontSize: 8)),
              Text('${award.current} / ${award.total}',
                  style: theme.textTheme.labelMono.copyWith(fontSize: 9)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 8 : 4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surfaceVariant,
              color: award.accent,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppTheme.outlineVariant),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(award.stats.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(award.labels[index],
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 7)),
                  Text(
                    award.stats[index],
                    style: theme.textTheme.labelMono.copyWith(
                      fontSize: 9,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import '../../providers/awards_provider.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';

class AwardsScreen extends ConsumerWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMobile = SizerUtil.deviceType == DeviceType.mobile;
    final awardsAsync = ref.watch(awardsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: awardsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (awards) {
            if (awards.isEmpty) {
              return const Center(child: Text('No awards data available'));
            }

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 4.w : 2.w),
              children: [
                SizedBox(height: 2.h),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'HorizonQRZLogo_Transparent.png',
                        height: isMobile ? 8.h : 12.h,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.military_tech,
                          size: 8.h,
                          color: AppTheme.primary,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Your QRZ.com Client',
                        style: theme.textTheme.labelLarge?.copyWith(
                          letterSpacing: 1.5,
                          color: AppTheme.onSurfaceVariant,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'AWARDS GALLERY',
                  style: theme.textTheme.displayLarge?.copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 2.h),
                if (isMobile || awards.length <= 1)
                  ...awards.map((award) => Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: _buildAwardCard(context, award, isMobile),
                      ))
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 2,
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 2.h,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: awards.length,
                    itemBuilder: (context, index) =>
                        _buildAwardCard(context, awards[index], isMobile),
                  ),
                SizedBox(height: 4.h),
              ],
            );
          },
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
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      award.subtitle,
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 7.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: award.completed ? AppTheme.tertiary : AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(isMobile ? 2.w : 1.w),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Text(
                  award.completed ? 'COMPLETED' : 'ACTIVE',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: 7.sp,
                    color: award.completed ? Colors.white : AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(award.unitLabel, style: theme.textTheme.labelLarge?.copyWith(fontSize: 8.sp)),
              Text('${award.current} / ${award.total}',
                  style: theme.textTheme.labelMono.copyWith(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 0.5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 2.w : 1.w),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surfaceVariant,
              color: award.accent,
              minHeight: 0.8.h,
            ),
          ),
          SizedBox(height: 2.h),
          const Divider(height: 1, color: AppTheme.outlineVariant),
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(award.stats.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(award.labels[index],
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 7.sp)),
                  Text(
                    award.stats[index],
                    style: theme.textTheme.labelMono.copyWith(
                      fontSize: 9.sp,
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

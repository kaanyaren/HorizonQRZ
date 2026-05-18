import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme.dart';
import '../widgets/instrument_card.dart';

class AwardsScreen extends StatelessWidget {
  const AwardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = SizerUtil.deviceType == DeviceType.mobile;

    // Move awards list here to ensure it uses the latest context and sizer values
    final awards = [
      _buildAwardCard(
        context,
        'DXCC',
        'DX CENTURY CLUB • MIXED',
        'Entities',
        88,
        100,
        ['94', '88', '0'],
        ['WORKED', 'CONFIRMED', 'VERIFIED'],
        AppTheme.primary,
        isMobile,
      ),
      _buildAwardCard(
        context,
        'WAS',
        'WORKED ALL STATES • PHONE',
        'States',
        50,
        50,
        ['50', '50', '#1492'],
        ['WORKED', 'CONFIRMED', 'ISSUED'],
        AppTheme.tertiary,
        isMobile,
        completed: true,
      ),
      _buildAwardCard(
        context,
        'WAZ',
        'WORKED ALL ZONES • CW',
        'Zones',
        31,
        40,
        ['34', '31', '9'],
        ['WORKED', 'CONFIRMED', 'MISSING'],
        AppTheme.primary,
        isMobile,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent, // Ensure background shows through
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 4.w : 2.w),
          children: [
            SizedBox(height: 2.h),
            // Branding Header
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
            
            // Awards Grid/List
            if (isMobile || awards.length <= 1)
              ...awards.map((award) => Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: award,
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
                itemBuilder: (context, index) => awards[index],
              ),
            
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardCard(
    BuildContext context,
    String title,
    String subtitle,
    String unitLabel,
    int current,
    int total,
    List<String> stats,
    List<String> labels,
    Color accent,
    bool isMobile, {
    bool completed = false,
  }) {
    final theme = Theme.of(context);
    final progress = (current / total).clamp(0.0, 1.0);

    return InstrumentCard(
      accentColor: accent,
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
                      title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.labelLarge?.copyWith(fontSize: 7.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: completed ? AppTheme.tertiary : AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(isMobile ? 2.w : 1.w),
                  border: Border.all(color: AppTheme.outlineVariant),
                ),
                child: Text(
                  completed ? 'COMPLETED' : 'ACTIVE',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: 7.sp,
                    color: completed ? Colors.white : AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 2.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(unitLabel, style: theme.textTheme.labelLarge?.copyWith(fontSize: 8.sp)),
              Text('$current / $total', style: theme.textTheme.labelMono.copyWith(fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 0.5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 2.w : 1.w),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.surfaceVariant,
              color: accent,
              minHeight: 0.8.h,
            ),
          ),
          SizedBox(height: 2.h),
          const Divider(height: 1, color: AppTheme.outlineVariant),
          SizedBox(height: 1.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(stats.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(labels[index], style: theme.textTheme.labelLarge?.copyWith(fontSize: 7.sp)),
                  Text(
                    stats[index],
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/app_providers.dart';
import '../theme.dart';
import '../widgets/banner_ad_widget.dart';
import 'dashboard_screen.dart';
import 'logger_screen.dart';
import 'logbook_screen.dart';
import 'awards_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobile = SizerUtil.deviceType == DeviceType.mobile;
    final selectedIndex = ref.watch(navigationProvider);

    final List<Widget> screens = [
      const DashboardScreen(),
      const LoggerScreen(),
      const LogbookScreen(),
      const AwardsScreen(),
      const SettingsScreen(),
    ];

    ref.listen<AppNotification?>(notificationProvider, (previous, next) {
      if (next != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (next.title != null)
                  Text(
                    next.title!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                Text(next.message),
              ],
            ),
            backgroundColor: next.isError ? AppTheme.error : AppTheme.primary,
            action: SnackBarAction(
              label: 'DISMISS',
              textColor: Colors.white,
              onPressed: () {
                ref.read(notificationProvider.notifier).clear();
              },
            ),
          ),
        );
      }
    });

    return ShowCaseWidget(
      builder: (context) => Scaffold(
        body: Column(
          children: [
            if (selectedIndex != 4) const BannerAdWidget(),
            Expanded(
              child: isMobile
                  ? screens[selectedIndex]
                  : Row(
                      children: [
                        NavigationRail(
                          selectedIndex: selectedIndex,
                          onDestinationSelected: (index) {
                            ref.read(navigationProvider.notifier).setTab(index);
                          },
                          labelType: NavigationRailLabelType.all,
                          backgroundColor: AppTheme.surface,
                          indicatorColor: AppTheme.primary.withOpacity(0.1),
                          selectedIconTheme: IconThemeData(color: AppTheme.primary, size: 20.sp),
                          unselectedIconTheme: IconThemeData(color: AppTheme.onSurfaceVariant, size: 20.sp),
                          selectedLabelTextStyle: GoogleFonts.ibmPlexSans(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                          unselectedLabelTextStyle: GoogleFonts.ibmPlexSans(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.onSurfaceVariant,
                          ),
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.dashboard_outlined),
                              selectedIcon: Icon(Icons.dashboard),
                              label: Text('Home'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.add_circle_outline),
                              selectedIcon: Icon(Icons.add_circle),
                              label: Text('Log'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.history),
                              selectedIcon: Icon(Icons.history),
                              label: Text('Logbook'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.military_tech_outlined),
                              selectedIcon: Icon(Icons.military_tech),
                              label: Text('Awards'),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.settings_outlined),
                              selectedIcon: Icon(Icons.settings),
                              label: Text('Settings'),
                            ),
                          ],
                        ),
                        const VerticalDivider(thickness: 1, width: 1, color: AppTheme.outlineVariant),
                        Expanded(child: screens[selectedIndex]),
                      ],
                    ),
            ),
          ],
        ),
        bottomNavigationBar: isMobile
            ? Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  boxShadow: [
                    BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
                  ],
                  border: const Border(
                    top: BorderSide(color: AppTheme.outlineVariant),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    child: GNav(
                      rippleColor: AppTheme.primary.withOpacity(0.1),
                      hoverColor: AppTheme.primary.withOpacity(0.05),
                      gap: 2.w,
                      activeColor: Colors.white,
                      iconSize: 18.sp,
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.5.h,
                      ),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: AppTheme.primary,
                      color: AppTheme.onSurfaceVariant,
                      tabs: const [
                        GButton(icon: Icons.dashboard_outlined, text: 'Home'),
                        GButton(icon: Icons.add_circle_outline, text: 'Log'),
                        GButton(icon: Icons.history, text: 'Logbook'),
                        GButton(icon: Icons.military_tech_outlined, text: 'Awards'),
                        GButton(icon: Icons.settings_outlined, text: 'Settings'),
                      ],
                      selectedIndex: selectedIndex,
                      onTabChange: (index) {
                        ref.read(navigationProvider.notifier).setTab(index);
                      },
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import '../../providers/app_providers.dart';
import '../theme.dart';
import 'logger_screen.dart';
import 'logbook_screen.dart';
import 'dashboard_screen.dart';
import 'settings_screen.dart';


class TabItem {
  final IconData icon;
  final String label;
  final String path;
  
  TabItem(this.icon, this.label, {required this.path});
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final tabs = [
    TabItem(Icons.home_rounded, 'Home', path: '/'),
    TabItem(Icons.add_circle_rounded, 'Log', path: '/logger'),
    TabItem(Icons.book_rounded, 'Logbook', path: '/logbook'),
    TabItem(Icons.settings_rounded, 'Settings', path: '/settings'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 450;
    
    // Calculate custom beautiful widths for the floating bar
    final barWidth = screenWidth > 600 ? 460.0 : screenWidth - 24;

    final itemPadding = isMobile 
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 8) 
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
    final iconSize = isMobile ? 22.0 : 24.0;
    final fontSize = isMobile ? 12.0 : 13.0;
    final gap = isMobile ? 4.0 : 6.0;

    final screens = [
      const DashboardScreen(),
      const LoggerScreen(),
      const LogbookScreen(),
      const SettingsScreen(),
    ];

    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          extendBody: true,
          body: BottomBar(
            showIcon: false,
            scrollBehavior: const BottomBarScrollBehavior(
              hideOnScroll: true,
            ),
            layout: BottomBarLayout(
              width: barWidth,
              borderRadius: BorderRadius.circular(32),
              offset: 12,
              alignment: Alignment.bottomCenter,
              respectSafeArea: true,
            ),
            theme: BottomBarThemeData(
              barDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.92),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: AppTheme.primary.withOpacity(0.12),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  height: isMobile ? 58 : 66,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(tabs.length, (index) {
                      final tab = tabs[index];
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          ref.read(navigationProvider.notifier).setTab(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          padding: itemPadding,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppTheme.primary.withOpacity(0.12) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                tab.icon,
                                color: isSelected 
                                    ? AppTheme.primary 
                                    : AppTheme.onSurfaceVariant,
                                size: iconSize,
                              ),
                              if (isSelected) ...[
                                SizedBox(width: gap),
                                Text(
                                  tab.label,
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            body: IndexedStack(
              index: selectedIndex,
              children: screens,
            ),
          ),
        );
      },
    );
  }
}


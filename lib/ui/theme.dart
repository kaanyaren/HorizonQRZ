import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTheme {
  // Brand Colors from Design System
  static const Color primary = Color(0xFF303E51);
  static const Color primaryContainer = Color(0xFF475569);
  static const Color onPrimaryContainer = Color(0xFFBBCAE1);
  static const Color tertiary = Color(0xFF004633);
  static const Color secondary = Color(0xFF5D5F5F);
  static const Color tertiaryContainer = Color(0xFF086047);
  static const Color onTertiaryContainer = Color(0xFF8DD8B8);
  static const Color background = Color(0xFFF7F9FF);
  static const Color surface = Color(0xFFF7F9FF);
  static const Color surfaceContainer = Color(0xFFE7EEF9);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEDF4FF);
  static const Color surfaceContainerHigh = Color(0xFFE2E9F4);
  static const Color surfaceContainerHighest = Color(0xFFDCE3EE);
  static const Color surfaceVariant = Color(0xFFDCE3EE);
  static const Color onSurface = Color(0xFF151C24);
  static const Color onSurfaceVariant = Color(0xFF44474C);
  static const Color outline = Color(0xFF75777D);
  static const Color outlineVariant = Color(0xFFC4C6CD);
  static const Color error = Color(0xFFBA1A1A);

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.ibmPlexSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: Color(0xFF5D5F5F),
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFDFE0E0),
        onSecondaryContainer: Color(0xFF616363),
        tertiary: tertiary,
        onTertiary: Colors.white,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: Colors.white,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        surfaceContainer: surfaceContainer,
        surfaceContainerLow: surfaceContainerLow,
        surfaceContainerHigh: surfaceContainerHigh,
        surfaceContainerHighest: surfaceContainerHighest,
        surfaceContainerLowest: surfaceContainerLowest,
      ),
      scaffoldBackgroundColor: Colors.transparent,
      
      // Typography
      textTheme: textTheme.copyWith(
        displayLarge: GoogleFonts.ibmPlexSans(
          fontSize: 22.sp, // ~32px on standard mobile
          fontWeight: FontWeight.w600,
          letterSpacing: -0.64,
          color: primary,
        ),
        headlineMedium: GoogleFonts.ibmPlexSans(
          fontSize: 18.sp, // ~24px
          fontWeight: FontWeight.w600,
          letterSpacing: -0.24,
          color: onSurface,
        ),
        headlineSmall: GoogleFonts.ibmPlexSans(
          fontSize: 16.sp, // ~20px
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.ibmPlexSans(
          fontSize: 12.sp, // ~16px
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodyMedium: GoogleFonts.ibmPlexSans(
          fontSize: 10.sp, // ~14px
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        labelLarge: GoogleFonts.ibmPlexSans(
          fontSize: 9.sp, // ~12px
          fontWeight: FontWeight.w700,
          letterSpacing: 0.96,
          color: onSurfaceVariant,
        ),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: primary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.ibmPlexSans(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.4,
          color: primary,
        ),
        shape: const Border(
          bottom: BorderSide(color: outlineVariant, width: 1),
        ),
      ),

      // NavigationBar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        elevation: 0,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.ibmPlexSans(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: primary,
            );
          }
          return GoogleFonts.ibmPlexSans(
            fontSize: 9.sp,
            fontWeight: FontWeight.w400,
            color: onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: primary, size: 18.sp);
          }
          return IconThemeData(color: onSurfaceVariant, size: 18.sp);
        }),
      ),

      // Card
      cardTheme: CardThemeData(
        color: surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: outlineVariant, width: 1),
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.ibmPlexSans(
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.96,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: outline),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.ibmPlexSans(
            fontSize: 9.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.96,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLowest,
        contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1),
        ),
        labelStyle: GoogleFonts.ibmPlexSans(
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.96,
          color: onSurfaceVariant,
        ),
      ),
    );
  }
}

// Extension for Mono font
extension MonoText on TextTheme {
  TextStyle get labelMono => GoogleFonts.ibmPlexMono(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.65,
  );
}


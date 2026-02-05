import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._(); // no instances

  /// Main dark theme for WORKSPACE
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,


      // CORE COLORS

      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      canvasColor: AppColors.backgroundPrimary,

      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentPrimary,
        secondary: AppColors.accentSoft,
        surface: AppColors.surfaceWindow,
        error: AppColors.stateError,
      ),


      // TEXT THEME

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
        ),
        bodySmall: TextStyle(
          color: AppColors.textMuted,
        ),
      ),


      // APP BAR (MENU BAR / TOP PANELS)

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceMenuBar,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textSecondary,
        ),
      ),


      // DIVIDERS & BORDERS

      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
      ),


      // BUTTON THEMES (MINIMAL, OS-LIKE)

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accentPrimary,
          textStyle: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.surfaceWindow,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),


      // INPUTS (RARE, BUT CLEAN)

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWindow,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderSubtle),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderSubtle),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.borderFocus(opacity: 0.8),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textMuted,
        ),
      ),


      // ICONS

      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
      ),


      // ANIMATION & INTERACTION FEEL

      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: AppColors.accentPrimary.withValues(alpha: 0.05),


      // MATERIAL 3 (DISABLED FOR OS FEEL)

      useMaterial3: false,
    );
  }
}

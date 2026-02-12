import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    // Add more theme config
  );
}

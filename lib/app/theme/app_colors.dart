import 'package:flutter/material.dart';

// WORKSPACE Color System

class AppColors {
  AppColors._(); // no instances


  // SYSTEM BACKGROUNDS

  static const Color backgroundPrimary = Color(0xFF0B0F14);
  static const Color backgroundSecondary = Color(0xFF0F1620);
  static const Color backgroundElevated = Color(0xFF141C27);


  // SURFACES (WINDOWS, PANELS, DOCK)

  static const Color surfaceWindow = Color(0xFF121A24);
  static const Color surfaceDock = Color(0xFF161F2C);
  static const Color surfaceMenuBar = Color(0xFF0F151E);


  // TEXT COLORS

  static const Color textPrimary = Color(0xFFE6EAF0);
  static const Color textSecondary = Color(0xFF9AA4B2);
  static const Color textMuted = Color(0xFF6E7683);
  static const Color textDisabled = Color(0xFF4A515C);


  // ACCENT (SYSTEM BLUE)

  static const Color accentPrimary = Color(0xFF3B82F6);
  static const Color accentSoft = Color(0xFF60A5FA);


  // BORDERS & DIVIDERS

  static const Color borderSubtle = Color(0xFF1F2937);

  // Focus border usually uses accent with opacity
  static Color borderFocus({double opacity = 0.6}) =>
      // ignore: deprecated_member_use
      accentPrimary.withOpacity(opacity);


  // STATE COLORS (RARE USE)

  static const Color stateSuccess = Color(0xFF22C55E);
  static const Color stateWarning = Color(0xFFF59E0B);
  static const Color stateError = Color(0xFFEF4444);

  // TERMINAL COLORS
  static const Color terminalBlue = Color(0xFF3B82F6); 
  static const Color terminalText = Color(0xFFE6EAF0);
  static const Color terminalDim = Color(0xFF6E7683); 
}

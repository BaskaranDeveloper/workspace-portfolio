import 'package:flutter/material.dart';

/// Defines the contract for any application that can be installed/run
/// in the workspace OS.
abstract class AppManifest {
  /// Unique identifier for the app (e.g., 'com.portfolio.terminal')
  String get id;

  /// Display name of the app (e.g., 'Terminal')
  String get name;

  /// Icon to display in the dock and app launcher
  IconData get icon;

  /// Theme color associated with the app (optional)
  Color? get themeColor;

  /// Whether the app supports multiple windows
  bool get allowMultiWindow;

  /// The widget to render when the app is opened.
  /// [args] can contain launch parameters.
  Widget buildApp(Map<String, dynamic> args);
}

import 'package:flutter/widgets.dart';

/// Represents an application installed in the system.
///
/// This entity decouples the application definition from the UI, allowing
/// different presenters (Desktop vs Mobile) to render the app appropriately.
class SystemApp {
  final String id;
  final String title;
  final IconData icon;
  final Color themeColor;

  /// Builder for the Desktop Window content
  final WidgetBuilder desktopBuilder;

  /// Builder for the Mobile Route content
  final WidgetBuilder mobileBuilder;

  final bool showInDock;
  final bool showInMobileHome;

  const SystemApp({
    required this.id,
    required this.title,
    required this.icon,
    required this.themeColor,
    required this.desktopBuilder,
    required this.mobileBuilder,
    this.showInDock = true,
    this.showInMobileHome = true,
  });
}

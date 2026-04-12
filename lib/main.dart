import 'dart:js' as js;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'bootstrap/app_runner.dart';

void main() {
  // First check to remove preloader (Web only)
  if (kIsWeb) {
    try {
      js.context.callMethod('_removePreloader');
    } catch (e) {
      debugPrint('Failed to remove preloader in main: $e');
    }
  }

  runApp(const ProviderScope(child: WorkspaceApp()));
}

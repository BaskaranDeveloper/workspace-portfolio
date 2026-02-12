import 'package:flutter/material.dart';

class WindowModel {
  final String id;
  final String title;
  final Widget content;

  Offset position;
  Size size;
  bool isMinimized;
  bool isMaximized;

  // Previous State (for restoring)
  Offset? _preMaximizedPosition;
  Size? _preMaximizedSize;

  WindowModel({
    required this.id,
    required this.title,
    required this.content,
    this.position = const Offset(100, 100),
    this.size = const Size(600, 400),
    this.isMinimized = false,
    this.isMaximized = false,
  });

  // Helper before save state before maximzing

  void saveState() {
    _preMaximizedPosition = position;
    _preMaximizedSize = size;
  }

  // Helper to restore state after maximzing

  void restoreState() {
    if (_preMaximizedPosition != null && _preMaximizedSize != null) {
      position = _preMaximizedPosition!;
      size = _preMaximizedSize!;
    }
  }
}

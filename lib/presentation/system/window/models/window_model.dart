import 'package:flutter/material.dart';

class WindowModel {
  final String id;
  final String title;
  final Widget content;

  Offset position;
  Size size;
  bool isMinimized;
  bool isMaximized;

  WindowModel({
    required this.id,
    required this.title,
    required this.content,
    this.position = const Offset(100, 100),
    this.size = const Size(600, 400),
    this.isMinimized = false,
    this.isMaximized = false,
  });
}

import 'package:flutter/material.dart';

class DesktopItem {
  final String id;
  final String label;
  final IconData icon;
  final String? iconPath;
  final Color color;
  Offset position;
  bool isSelected;

  DesktopItem({
    required this.id,
    required this.label,
    required this.icon,
    this.iconPath,
    required this.color,
    this.position = const Offset(20, 60),
    this.isSelected = false,
  });
}

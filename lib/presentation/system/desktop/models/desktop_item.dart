import 'package:flutter/material.dart';

class DesktopItem {
  final String id;
  final String label;
  final IconData icon;
  final Color color;
  Offset position;
  bool isSelected;

  DesktopItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    this.position = const Offset(20, 40),
    this.isSelected = false,
  });
}

import 'package:flutter/material.dart';

class MenuItemData {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  MenuItemData({required this.label, this.icon, required this.onTap});
}

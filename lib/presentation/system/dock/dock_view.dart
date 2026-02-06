import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workspace/presentation/system/dock/widgets/dock_item.dart';
import 'package:workspace/presentation/system/dock/dock_item_data.dart';

class DockView extends StatefulWidget {
  const DockView({super.key});

  @override
  State<DockView> createState() => _DockViewState();
}

class _DockViewState extends State<DockView> {
  // Define  dock items here
  // Define  dock items here
  final List<DockItemData> _items = const [
    DockItemData(icon: Icons.person, color: Colors.blue, label: 'About'),
    DockItemData(icon: Icons.folder, color: Colors.purple, label: 'Projects'),
    DockItemData(icon: Icons.work, color: Colors.grey, label: 'Experience'),
    DockItemData(icon: Icons.school, color: Colors.green, label: 'Education'),
    DockItemData(icon: Icons.mail, color: Colors.red, label: 'Contact'),
  ];

  // Track which item is being hovered
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_items.length, (index) {
                final item = _items[index];
                return DockItem(
                  icon: item.icon,
                  label: item.label,
                  color: item.color,
                  isHovered: _hoveredIndex == index,
                  onHover: () => setState(() => _hoveredIndex = index),
                  onExit: () => setState(() => _hoveredIndex = null),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workspace/presentation/system/desktop/models/menu_item_data.dart';

class ContextMenu extends StatelessWidget {
  final List<MenuItemData> items;

  const ContextMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.map((item) => _buildItem(item)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(MenuItemData item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        hoverColor: Colors.blueAccent.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              if (item.icon != null) ...[
                Icon(item.icon, size: 16, color: Colors.white),
                const SizedBox(width: 10),
              ],
              Text(
                item.label,
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

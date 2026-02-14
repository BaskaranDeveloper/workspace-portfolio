import 'package:flutter/material.dart';

class SystemMenu extends StatelessWidget {
  final String label;
  final List<MenuEntry> entries;

  const SystemMenu({super.key, required this.label, required this.entries});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
      menuChildren: entries.map((entry) {
        if (entry is MenuDivider) {
          return const Divider(height: 8);
        }
        final item = entry as MenuItem;
        return MenuItemButton(
          onPressed: item.onTap,
          shortcut: item.shortcut,
          child: Text(item.label),
        );
      }).toList(),
    );
  }
}

abstract class MenuEntry {}

class MenuItem extends MenuEntry {
  final String label;
  final VoidCallback? onTap;
  final MenuSerializableShortcut? shortcut;

  MenuItem({required this.label, this.onTap, this.shortcut});
}

class MenuDivider extends MenuEntry {}

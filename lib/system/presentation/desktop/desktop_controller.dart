import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:workspace/system/presentation/desktop/models/desktop_item.dart';
import 'package:workspace/system/presentation/desktop/models/menu_item_data.dart';

class DesktopController extends ChangeNotifier {
  List<DesktopItem> items = [
    DesktopItem(
      id: '1',
      label: 'Projects',
      icon: LucideIcons.folder,
      iconPath: 'asset/icons/project.png',
      color: Colors.blue,
      position: const Offset(20, 60),
    ),
    DesktopItem(
      id: '2',
      label: 'Resume',
      icon: LucideIcons.fileText,
      iconPath: 'asset/icons/notes.png',
      color: Colors.white,
      position: const Offset(20, 160),
    ),
    DesktopItem(
      id: '3',
      label: 'Photo.jpg',
      icon: LucideIcons.image,
      iconPath: 'asset/icons/skill.png', // Assuming skills is photos related or use image icon
      color: Colors.green,
      position: const Offset(20, 260),
    ),
  ];

  // context menu list
  Offset? menuPosition;
  List<MenuItemData> menuItems = [];

  void showMenu(Offset position, List<MenuItemData> items) {
    menuPosition = position;
    menuItems = items;
    notifyListeners();
  }

  void clearMenu() {
    if (menuPosition != null) {
      menuPosition = null;
      menuItems = [];
      notifyListeners();
    }
  }

  void updateItemPosition(String id, Offset newPosition) {
    final index = items.indexWhere((item) => item.id == id);
    if (index != -1) {
      // Grid Snapping (Simple Version)
      double dx = (newPosition.dx / 100).round() * 100.0;
      double dy = (newPosition.dy / 100).round() * 100.0;

      // Boundary check
      if (dx < 0) dx = 0;
      if (dy < 40) dy = 60; //Kepp below top bar

      items[index].position = Offset(dx, dy);
      notifyListeners();
    }
  }

  void selectItem(String id) {
    for (var item in items) {
      item.isSelected = (item.id == id);
    }
    notifyListeners();
  }

  void clearSelection() {
    for (var item in items) {
      item.isSelected = false;
    }
    notifyListeners();
  }
}

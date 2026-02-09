import 'package:flutter/material.dart';
import 'package:workspace/presentation/system/desktop/models/desktop_item.dart';

class DesktopController extends ChangeNotifier {
  List<DesktopItem> items = [
    DesktopItem(
      id: '1',
      label: 'Projects',
      icon: Icons.folder,
      color: Colors.blue,
      position: const Offset(20, 60),
    ),
    DesktopItem(
      id: '2',
      label: 'Resume',
      icon: Icons.description,
      color: Colors.white,
      position: const Offset(20, 160),
    ),
    DesktopItem(
      id: '3',
      label: 'Photo.jpg',
      icon: Icons.image,
      color: Colors.green,
      position: const Offset(20, 260),
    ),
  ];

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
      item.isSelected = (item == id);
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

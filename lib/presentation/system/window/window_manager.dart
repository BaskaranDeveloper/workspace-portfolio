import 'package:flutter/material.dart';
import 'models/window_model.dart';

class WindowManager extends ChangeNotifier {
  List<WindowModel> windows = [];

  void openWindow(WindowModel window) {
    // If already open, bring to front
    final index = windows.indexWhere((w) => w.id == window.id);
    if (index != -1) {
      bringToFront(window.id);
    } else {
      windows.add(window);
      notifyListeners();
    }
  }

  void closeWindow(String id) {
    windows.removeWhere((w) => w.id == id);
    notifyListeners();
  }

  void updateWindowPosition(String id, Offset newPos) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      windows[index].position = newPos;
      notifyListeners();
    }
  }

  void bringToFront(String id) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = windows.removeAt(index);
      windows.add(window); // move to end of list top of stack
      notifyListeners();
    }
  }
}

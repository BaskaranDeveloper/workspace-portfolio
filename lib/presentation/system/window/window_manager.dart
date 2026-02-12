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

  void updateWindowPosition(String id, Offset newPos, Size screenSize) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = windows[index];
      // Clamp values
      // X: Between 0 and ScreenWidth - WindowWidth
      double clampedX = newPos.dx.clamp(
        0,
        screenSize.width - window.size.width,
      );

      // Y: Between TopBar (30) and ScreenHeight - Dock (90)
      // Note: We allow partial overlap with Dock, but not total disappearance
      double clampedY = newPos.dy.clamp(30, screenSize.height - 50);

      windows[index].position = Offset(clampedX, clampedY);
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

  void updateWindowSize(String id, Size newSize) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      windows[index].size = newSize;
      notifyListeners();
    }
  }

  void toggleMaximize(String id) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = windows[index];
      if (window.isMaximized) {
        // Resetore
        window.restoreState();
        window.isMaximized = false;
      } else {
        // Maximize
        window.saveState();
        window.position = Offset.zero;
        window.isMaximized = true;
      }
      notifyListeners();
    }
  }

  void minimizeWindow(String id) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      windows[index].isMinimized = true;
      notifyListeners();
    }
  }
}

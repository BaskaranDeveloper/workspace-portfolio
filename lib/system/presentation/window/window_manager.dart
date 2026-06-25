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

      // Check if any window is maximized to decide top clamping
      final isAnyMaximized = windows.any((w) => w.isMaximized);
      double topClamp = isAnyMaximized ? 0 : 30;

      // Y: Between TopBoundary and ScreenHeight - Dock
      double clampedY = newPos.dy.clamp(topClamp, screenSize.height - 50);

      windows[index].position = Offset(clampedX, clampedY);
      notifyListeners();
    }
  }

  void bringToFront(String id) {
    final index = windows.indexWhere((w) => w.id == id);
    if (index != -1) {
      final window = windows.removeAt(index);
      window.isMinimized = false; // Restore if it was minimized
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

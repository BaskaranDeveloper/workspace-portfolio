import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';
import 'package:workspace/presentation/system/dock/dock_view.dart';
import 'package:workspace/presentation/system/window/models/window_model.dart';
import 'package:workspace/presentation/system/window/widgets/window_base.dart';
import 'package:workspace/presentation/system/window/window_manager.dart';
import 'widgets/system_bar.dart';
import 'desktop_controller.dart';
import 'widgets/desktop_icon.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({super.key});

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  // 1. Create the controller
  final DesktopController _controller = DesktopController();

  // 2. Create the window manager
  final WindowManager _windowManager = WindowManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. Wrap body in ListenableBuilder to rebuild when controller changes
      body: ListenableBuilder(
        listenable: Listenable.merge([_controller, _windowManager]),
        builder: (context, child) {
          return Stack(
            children: [
              // 1. Background
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => _controller
                      .clearSelection(), // Click empty space to deselect
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.backgroundDark,
                          AppColors.backgroundSecondary,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 2. Desktop Icons Loop
              // We map each item from the controller to a DesktopIcon widget
              ..._controller.items.map((item) {
                return DesktopIcon(
                  item: item,
                  onTap: () => _controller.selectItem(item.id),
                  onDoubleTap: () {
                    // We will add window opening here later
                    _windowManager.openWindow(
                      WindowModel(
                        id: item.id,
                        title: item.label,
                        content: Center(child: Text("App: ${item.label}")),
                      ),
                    );
                  },
                  onDragEnd: (offset) {
                    // Valid drag ended, update model
                    _controller.updateItemPosition(item.id, offset);
                  },
                );
              }),
              // windows layer
              ..._windowManager.windows.map((window) {
                return WindowBase(
                  window: window,
                  onClose: () => _windowManager.closeWindow(window.id),
                  onMinimize: () => _windowManager.closeWindow(window.id),
                  onMaximize: () => _windowManager.closeWindow(window.id),
                  onDrag: (offset) =>
                      _windowManager.updateWindowPosition(window.id, offset),
                  onFocus: () => _windowManager.bringToFront(window.id),
                );
              }),
              // 3. System Bar (Top)
              const Positioned(top: 0, left: 0, right: 0, child: SystemBar()),

              // 4. Dock (Bottom)
              Positioned(left: 0, right: 0, bottom: 20, child: DockView()),
            ],
          );
        },
      ),
    );
  }
}

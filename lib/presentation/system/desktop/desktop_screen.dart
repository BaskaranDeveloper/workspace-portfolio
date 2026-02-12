import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workspace/app/theme/app_colors.dart';
import 'package:workspace/presentation/system/desktop/models/menu_item_data.dart';
import 'package:workspace/presentation/system/dock/dock_view.dart';
import 'package:workspace/presentation/system/window/models/window_model.dart';
import 'package:workspace/presentation/system/window/widgets/window_base.dart';
import 'package:workspace/presentation/system/window/window_manager.dart';
import 'widgets/system_bar.dart';
import 'context_menu.dart';
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
  void initState() {
    super.initState();
    // Disable default browser context menu
    BrowserContextMenu.disableContextMenu();
  }

  @override
  void dispose() {
    // Re-enable it when leaving the desktop (optional but good practice)
    BrowserContextMenu.enableContextMenu();
    super.dispose();
  }

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
                  onTap: () {
                    _controller.clearSelection();
                    _controller.clearMenu();
                  },
                  onSecondaryTapUp: (details) {
                    _controller.showMenu(details.globalPosition, [
                      MenuItemData(
                        label: 'New Folder',
                        icon: Icons.create_new_folder,
                        onTap: () {
                          print('New Folder');
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Change Wallpaper',
                        icon: Icons.wallpaper,
                        onTap: () {
                          print('Wallpaper');
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Refresh',
                        icon: Icons.refresh,
                        onTap: () {
                          print('Refresh');
                          _controller.clearMenu();
                        },
                      ),
                    ]);
                  },

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
                  onSecondaryTap: () {
                    _controller.showMenu(item.position + const Offset(50, 50), [
                      MenuItemData(
                        label: 'Open',
                        icon: Icons.open_in_new,
                        onTap: () {
                          _windowManager.openWindow(
                            WindowModel(
                              id: item.id,
                              title: item.label,
                              content: Center(
                                child: Text("App: ${item.label}"),
                              ),
                            ),
                          );
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Delete',
                        icon: Icons.delete,
                        onTap: () {
                          // TODO: Implement delete
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Properties',
                        icon: Icons.info_outline,
                        onTap: () => _controller.clearMenu(),
                      ),
                    ]);
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
                  onResize: (newSize) =>
                      _windowManager.updateWindowSize(window.id, newSize),
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
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: DockView(
                  onAppTap: (appName) {
                    _windowManager.openWindow(
                      WindowModel(
                        id: 'app_$appName',
                        title: appName,
                        content: Center(child: Text("$appName App")),
                      ),
                    );
                  },
                ),
              ),

              // 5. Context Menu Layer
              if (_controller.menuPosition != null)
                Positioned(
                  left: _controller.menuPosition!.dx,
                  top: _controller.menuPosition!.dy,
                  child: ContextMenu(items: _controller.menuItems),
                ),
            ],
          );
        },
      ),
    );
  }
}

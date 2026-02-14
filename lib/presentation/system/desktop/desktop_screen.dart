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
import 'package:workspace/presentation/apps/terminal/terminal_view.dart';
import 'package:workspace/presentation/apps/about/about_view.dart';
import 'package:workspace/presentation/apps/contact/contact_view.dart';
import 'package:workspace/presentation/apps/projects/projects_view.dart';
import 'package:workspace/presentation/apps/experience/experience_view.dart';
import 'package:workspace/presentation/apps/education/education_view.dart';
import 'package:workspace/presentation/apps/resume/resume_view.dart';

import 'package:workspace/presentation/system/desktop/overlays/control_center.dart';

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

  bool _isControlCenterOpen = false;

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

  void _toggleControlCenter() {
    setState(() {
      _isControlCenterOpen = !_isControlCenterOpen;
      // Close context menu if open
      if (_isControlCenterOpen) {
        _controller.clearMenu();
      }
    });
  }

  void _closeControlCenter() {
    if (_isControlCenterOpen) {
      setState(() {
        _isControlCenterOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 3. Wrap body in ListenableBuilder to rebuild when controller changes
      body: ListenableBuilder(
        listenable: Listenable.merge([_controller, _windowManager]),
        builder: (context, child) {
          // Check if any window is maximized
          final bool isAnyMaximized = _windowManager.windows.any(
            (w) => w.isMaximized,
          );

          return Stack(
            children: [
              // 1. Background
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    _controller.clearSelection();
                    _controller.clearMenu();
                    _closeControlCenter();
                  },
                  onSecondaryTapUp: (details) {
                    _closeControlCenter();
                    _controller.showMenu(details.globalPosition, [
                      MenuItemData(
                        label: 'New Folder',
                        icon: Icons.create_new_folder,
                        onTap: () {
                          // TODO: New Folder
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Change Wallpaper',
                        icon: Icons.wallpaper,
                        onTap: () {
                          // TODO: Change Wallpaper
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Refresh',
                        icon: Icons.refresh,
                        onTap: () {
                          // TODO: Refresh
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
              ..._controller.items.map((item) {
                return DesktopIcon(
                  item: item,
                  onTap: () {
                    _controller.selectItem(item.id);
                    _closeControlCenter();
                  },
                  onDoubleTap: () {
                    _closeControlCenter();
                    Widget content;
                    if (item.label == 'Projects') {
                      content = const ProjectsView();
                    } else if (item.label == 'Resume') {
                      content = const ResumeView();
                    } else {
                      content = Center(child: Text("App: ${item.label}"));
                    }

                    _windowManager.openWindow(
                      WindowModel(
                        id: item.id,
                        title: item.label,
                        content: content,
                        size: item.label == 'Projects'
                            ? const Size(900, 600)
                            : item.label == 'Resume'
                            ? const Size(820, 1100) // Approx A4 ratio + padding
                            : const Size(600, 400),
                      ),
                    );
                  },
                  onSecondaryTap: () {
                    _closeControlCenter();
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

              // 3. Dock (Rendered BEHIND windows if maximized)
              if (isAnyMaximized)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: DockView(
                    activeApps: _windowManager.windows
                        .map((w) => w.title)
                        .toList(),
                    onAppTap: (appName) {
                      _closeControlCenter();
                      Widget content;
                      if (appName == 'Terminal') {
                        content = const TerminalView();
                      } else if (appName == 'About') {
                        content = const AboutView();
                      } else if (appName == 'Contact') {
                        content = const ContactView();
                      } else if (appName == 'Projects') {
                        content = const ProjectsView();
                      } else if (appName == 'Experience') {
                        content = const ExperienceView();
                      } else if (appName == 'Education') {
                        content = const EducationView();
                      } else {
                        content = Center(child: Text("$appName App"));
                      }

                      _windowManager.openWindow(
                        WindowModel(
                          id: 'app_$appName',
                          title: appName,
                          content: content,
                          size: appName == 'Terminal'
                              ? const Size(600, 400)
                              : const Size(600, 400),
                        ),
                      );
                    },
                  ),
                ),

              // 4. Windows Layer (Now possibly on top of Dock)
              ..._windowManager.windows
                  .where((window) => !window.isMinimized)
                  .map((window) {
                    return WindowBase(
                      onResize: (newSize) =>
                          _windowManager.updateWindowSize(window.id, newSize),
                      window: window,
                      onClose: () => _windowManager.closeWindow(window.id),
                      onMaximize: () =>
                          _windowManager.toggleMaximize(window.id),
                      onMinimize: () =>
                          _windowManager.minimizeWindow(window.id),
                      onDrag: (offset) => _windowManager.updateWindowPosition(
                        window.id,
                        offset,
                        MediaQuery.of(context).size,
                      ),
                      onFocus: () {
                        _windowManager.bringToFront(window.id);
                        _closeControlCenter();
                      },
                    );
                  }),

              // 5. System Bar (Top)
              if (!isAnyMaximized)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SystemBar(onControlCenterTap: _toggleControlCenter),
                ),

              // 6. Dock (Rendered ON TOP of windows if NOT maximized)
              if (!isAnyMaximized)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: DockView(
                    activeApps: _windowManager.windows
                        .map((w) => w.title)
                        .toList(),
                    onAppTap: (appName) {
                      _closeControlCenter();
                      Widget content;
                      if (appName == 'Terminal') {
                        content = const TerminalView();
                      } else if (appName == 'About') {
                        content = const AboutView();
                      } else if (appName == 'Contact') {
                        content = const ContactView();
                      } else if (appName == 'Projects') {
                        content = const ProjectsView();
                      } else if (appName == 'Experience') {
                        content = const ExperienceView();
                      } else if (appName == 'Education') {
                        content = const EducationView();
                      } else {
                        content = Center(child: Text("$appName App"));
                      }

                      _windowManager.openWindow(
                        WindowModel(
                          id: 'app_$appName',
                          title: appName,
                          content: content,
                          size: appName == 'Terminal'
                              ? const Size(600, 400)
                              : const Size(600, 400),
                        ),
                      );
                    },
                  ),
                ),

              // 7. Context Menu Layer
              if (_controller.menuPosition != null)
                Positioned(
                  left: _controller.menuPosition!.dx,
                  top: _controller.menuPosition!.dy,
                  child: ContextMenu(items: _controller.menuItems),
                ),

              // 8. Control Center Overlay
              if (_isControlCenterOpen)
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _closeControlCenter,
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 38, // Below system bar
                            right: 16,
                            child: GestureDetector(
                              onTap: () {}, // Prevent tap from closing
                              child: const ControlCenter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

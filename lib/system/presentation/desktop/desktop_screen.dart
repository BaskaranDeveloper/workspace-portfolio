import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:go_router/go_router.dart';
import 'package:workspace/system/presentation/desktop/models/menu_item_data.dart';
import 'package:workspace/system/presentation/dock/dock_view.dart';
import 'package:workspace/system/presentation/window/models/window_model.dart';
import 'package:workspace/system/presentation/window/widgets/window_base.dart';
import 'package:workspace/system/presentation/window/window_manager.dart';
import 'widgets/system_bar.dart';
import 'context_menu.dart';
import 'desktop_controller.dart';
import 'widgets/desktop_icon.dart';
import 'package:workspace/system/domain/registry/registry_provider.dart'; // Import provider

import 'package:workspace/system/presentation/desktop/overlays/control_center.dart';
import 'package:workspace/system/presentation/desktop/overlays/launchpad_overlay.dart';
import 'widgets/parallax_background.dart';

// Convert to ConsumerStatefulWidget
class DesktopScreen extends ConsumerStatefulWidget {
  const DesktopScreen({super.key});

  @override
  ConsumerState<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends ConsumerState<DesktopScreen> {
  // 1. Create the controller
  final DesktopController _controller = DesktopController();

  // 2. Create the window manager
  final WindowManager _windowManager = WindowManager();

  bool _isControlCenterOpen = false;
  bool _isLaunchpadOpen = false;

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

  void _toggleLaunchpad() {
    setState(() {
      _isLaunchpadOpen = !_isLaunchpadOpen;
      if (_isLaunchpadOpen) {
        _closeControlCenter();
        _controller.clearMenu();
      }
    });
  }

  void _closeLaunchpad() {
    if (_isLaunchpadOpen) {
      setState(() {
        _isLaunchpadOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Responsive Redirection
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/mobile');
      });
      return const SizedBox.shrink();
    }

    // 2. Fetch apps from registry
    final appRegistry = ref.watch(appRegistryProvider);
    final dockApps = appRegistry.apps.where((app) => app.showInDock).toList();

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
                        icon: LucideIcons.folderPlus,
                        onTap: () {
                          // TODO: New Folder
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Change Wallpaper',
                        icon: LucideIcons.sparkles,
                        onTap: () {
                          // TODO: Change Wallpaper
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Refresh',
                        icon: LucideIcons.refreshCcw,
                        onTap: () {
                          // TODO: Refresh
                          _controller.clearMenu();
                        },
                      ),
                    ]);
                  },

                  child: const ParallaxBackground(),
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

                    // Try to find matching app in registry by label (fragile but works for migration)
                    // Ideally DesktopItems should link by ID
                    final app = appRegistry.apps.cast<dynamic>().firstWhere(
                      (a) => a.title == item.label,
                      orElse: () => null,
                    );

                    if (app != null) {
                      _windowManager.openWindow(
                        WindowModel(
                          id: app.id,
                          title: app.title,
                          content: app.desktopBuilder(context),
                          size: app.id == 'resume'
                              ? const Size(820, 1100)
                              : app.id == 'projects'
                              ? const Size(900, 600)
                              : const Size(600, 400),
                        ),
                      );
                    } else {
                      // Files or other items
                      _windowManager.openWindow(
                        WindowModel(
                          id: item.id,
                          title: item.label,
                          content: Center(child: Text("File: ${item.label}")),
                          size: const Size(600, 400),
                        ),
                      );
                    }
                  },
                  onSecondaryTap: () {
                    _closeControlCenter();
                    _controller.showMenu(item.position + const Offset(50, 50), [
                      MenuItemData(
                        label: 'Open',
                        icon: LucideIcons.externalLink,
                        onTap: () {
                          // Same open logic as double tap
                          final app = appRegistry.apps
                              .cast<dynamic>()
                              .firstWhere(
                                (a) => a.title == item.label,
                                orElse: () => null,
                              );

                          if (app != null) {
                            _windowManager.openWindow(
                              WindowModel(
                                id: app.id,
                                title: app.title,
                                content: app.desktopBuilder(context),
                                size: const Size(600, 400),
                              ),
                            );
                          } else {
                            _windowManager.openWindow(
                              WindowModel(
                                id: item.id,
                                title: item.label,
                                content: Center(
                                  child: Text("File: ${item.label}"),
                                ),
                                size: const Size(600, 400),
                              ),
                            );
                          }
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Delete',
                        icon: LucideIcons.trash,
                        onTap: () {
                          // TODO: Implement delete
                          _controller.clearMenu();
                        },
                      ),
                      MenuItemData(
                        label: 'Properties',
                        icon: LucideIcons.info,
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
                  bottom: 0,
                  child: DockView(
                    dockApps: dockApps,
                    activeApps: _windowManager.windows
                        .map((w) => w.title)
                        .toList(),
                    onAppTap: (app) {
                      _closeControlCenter();
                      if (app.id == 'launchpad') {
                        _toggleLaunchpad();
                        return;
                      }
                      _closeLaunchpad();
                      _windowManager.openWindow(
                        WindowModel(
                          id: 'app_${app.id}',
                          title: app.title,
                          content: app.desktopBuilder(context),
                          size: app.id == 'terminal'
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
                  bottom: 0,
                  child: DockView(
                    dockApps: dockApps,
                    activeApps: _windowManager.windows
                        .map((w) => w.title)
                        .toList(),
                    onAppTap: (app) {
                      _closeControlCenter();
                      if (app.id == 'launchpad') {
                        _toggleLaunchpad();
                        return;
                      }
                      _closeLaunchpad();
                      _windowManager.openWindow(
                        WindowModel(
                          id: 'app_${app.id}',
                          title: app.title,
                          content: app.desktopBuilder(context),
                          size: app.id == 'terminal' || app.id == 'settings'
                              ? const Size(600, 400)
                              : app.id == 'resume'
                              ? const Size(820, 1100)
                              : const Size(
                                  900,
                                  600,
                                ), // Default large size for projects/etc
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

              // 9. Launchpad Overlay
              if (_isLaunchpadOpen)
                Positioned.fill(
                  child: LaunchpadOverlay(
                    apps: appRegistry.apps,
                    onClose: _closeLaunchpad,
                    onAppTap: (app) {
                      _windowManager.openWindow(
                        WindowModel(
                          id: 'app_${app.id}',
                          title: app.title,
                          content: app.desktopBuilder(context),
                          size: const Size(600, 400),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

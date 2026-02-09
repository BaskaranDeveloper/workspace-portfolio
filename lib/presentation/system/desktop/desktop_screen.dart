import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';
import 'package:workspace/presentation/system/dock/dock_view.dart';
import 'widgets/system_bar.dart';
// Import your controller and widgets
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 2. Wrap body in ListenableBuilder to rebuild when controller changes
      body: ListenableBuilder(
        listenable: _controller,
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
                    print("Open ${item.label}");
                  },
                  onDragEnd: (offset) {
                    // Valid drag ended, update model
                    _controller.updateItemPosition(item.id, offset);
                  },
                );
              }).toList(),

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

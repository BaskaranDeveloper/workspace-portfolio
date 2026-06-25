import 'dart:math'; // Required for the exp() function (Gaussian curve)
import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'widgets/dock_item.dart';
import 'package:workspace/system/domain/entities/system_app.dart';

class DockView extends StatefulWidget {
  final Function(SystemApp app) onAppTap;
  final List<String> activeApps;
  final List<SystemApp> dockApps; // Apps to show in dock

  const DockView({
    super.key,
    required this.onAppTap,
    this.activeApps = const [],
    required this.dockApps,
  });

  @override
  State<DockView> createState() => _DockViewState();
}

class _DockViewState extends State<DockView> {
  // We track the mouse hovering over the dock to calculate the wave effect.
  double? _mouseX;

  @override
  Widget build(BuildContext context) {
    if (widget.dockApps.isEmpty) return const SizedBox.shrink();

    // Find index for divider (e.g., after the first 3 apps or static)
    // For now, let's put it before the last app (Settings) or after specific ones
    final int dividerIndex = widget.dockApps.length - 2;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 2),
          child: MouseRegion(
            onEnter: (event) => setState(() {
              _mouseX = event.localPosition.dx;
            }),
            onExit: (event) => setState(() {
              _mouseX = null;
            }),
            onHover: (event) => setState(() {
              _mouseX = event.localPosition.dx;
            }),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Glass background
                LiquidGlass(
                  borderRadius: 22,
                  width: (widget.dockApps.length * 62.0) + 60,
                  height: 66,
                  child: const SizedBox.shrink(),
                ),
                // Dock icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...List.generate(widget.dockApps.length, (index) {
                        final app = widget.dockApps[index];
                        final List<Widget> items = [];

                        items.add(
                          GestureDetector(
                            onTap: () => widget.onAppTap(app),
                            child: DockItem(
                              icon: app.icon,
                              iconPath: app.iconPath,
                              color: app.themeColor,
                              label: app.title,
                              size: _calculateSize(index),
                              isActive: widget.activeApps.contains(app.title),
                              duration: _mouseX == null
                                  ? const Duration(milliseconds: 300)
                                  : Duration.zero,
                            ),
                          ),
                        );

                        // Add divider
                        if (index == dividerIndex) {
                          items.add(
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              width: 0.5,
                              height: 40,
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          );
                        }

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: items,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calculateSize(int index) {
    const double baseSize = 44.0;
    const double maxSize = 78.0;
    const double itemWidth = 62.0;
    const double sigma = 45.0;

    if (_mouseX == null) {
      return baseSize;
    }

    double itemCenter = (index * itemWidth) + (itemWidth / 2) + 16; // Added padding offset
    double distance = (_mouseX! - itemCenter).abs();

    double scale = exp(-(distance * distance) / (2 * sigma * sigma));

    if (distance < itemWidth * 3) {
      return baseSize + (maxSize - baseSize) * scale * 1.1; // Add 1.1x boost to spring feel
    }

    return baseSize;
  }
}

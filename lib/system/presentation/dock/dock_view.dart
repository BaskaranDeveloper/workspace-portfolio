import 'dart:math'; // Required for the exp() function (Gaussian curve)
import 'dart:ui';
import 'package:flutter/material.dart';
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
    // If no apps, show empty or default?
    // In practice, we should always have apps.
    if (widget.dockApps.isEmpty) return const SizedBox.shrink();

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.all(20),
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
                SizedBox(
                  height: 70,
                  width: (widget.dockApps.length * 60.0) + 52,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.3),
                              Colors.white.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            width: 1.5,
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Dock icons
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(widget.dockApps.length, (index) {
                      final app = widget.dockApps[index];
                      return GestureDetector(
                        onTap: () => widget.onAppTap(app),
                        child: DockItem(
                          icon: app.icon, // Use SystemApp icon
                          color: app.themeColor, // Use SystemApp color
                          label: app.title, // Use SystemApp title
                          size: _calculateSize(index),
                          isActive: widget.activeApps.contains(
                            app.title,
                          ), // Or match by ID? Title for now to match activeApps
                          duration: _mouseX == null
                              ? const Duration(milliseconds: 300)
                              : Duration.zero,
                        ),
                      );
                    }),
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
    const double baseSize = 45.0;
    const double maxSize = 80.0;
    const double itemWidth = 60.0;
    const double sigma = 40.0;

    if (_mouseX == null) {
      return baseSize;
    }

    double itemCenter = (index * itemWidth) + (itemWidth / 2);
    double distance = (_mouseX! - itemCenter).abs();

    // Gaussian curve for smooth magnification
    double scale = exp(-(distance * distance) / (2 * sigma * sigma));

    if (distance < itemWidth * 2.5) {
      return baseSize + (maxSize - baseSize) * scale;
    }

    return baseSize;
  }
}

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workspace/system/domain/entities/system_app.dart';
import 'package:workspace/system/presentation/dock/widgets/dock_item.dart';

class LaunchpadOverlay extends StatefulWidget {
  final List<SystemApp> apps;
  final Function(SystemApp) onAppTap;
  final VoidCallback onClose;

  const LaunchpadOverlay({
    super.key,
    required this.apps,
    required this.onAppTap,
    required this.onClose,
  });

  @override
  State<LaunchpadOverlay> createState() => _LaunchpadOverlayState();
}

class _LaunchpadOverlayState extends State<LaunchpadOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250), // Snappy Mac speed
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredApps = widget.apps
        .where((app) =>
            app.id != 'launchpad' &&
            app.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return GestureDetector(
      onTap: widget.onClose,
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            color: Colors.black.withValues(alpha: 0.5), // Reduced visibility of background
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40), // Tighter padding
            child: ScaleTransition(
              scale: _animation,
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  children: [
                    // Search Bar (Slim & Subtle)
                    SizedBox(
                      width: 240, // Narrower
                      height: 32, // Slimmer
                      child: TextField(
                        autofocus: true,
                        onChanged: (value) => setState(() => _searchQuery = value),
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        cursorHeight: 14,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: Colors.white.withValues(alpha: 0.3),
                            size: 16,
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.zero, // Minimal height
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  // Grid (Paged Horizontal)
                  Expanded(
                    child: PageView.builder(
                      itemCount: (filteredApps.length / 28).ceil(),
                      itemBuilder: (context, pageIndex) {
                        final start = pageIndex * 28;
                        final end = (start + 28) > filteredApps.length
                            ? filteredApps.length
                            : start + 28;
                        final pageApps = filteredApps.sublist(start, end);

                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: pageApps.length,
                          itemBuilder: (context, index) {
                            final app = pageApps[index];
                            return GestureDetector(
                              onTap: () {
                                widget.onAppTap(app);
                                widget.onClose();
                              },
                              child: Column(
                                children: [
                                  DockItem(
                                    icon: app.icon,
                                    iconPath: app.iconPath,
                                    label: app.title,
                                    color: app.themeColor,
                                    size: 60, // Reduced size
                                    duration: const Duration(milliseconds: 200),
                                    isActive: false,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    app.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12, // Slightly smaller font
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10,
                                          color: Colors.black,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // Page Indicator (Simple Dots)
                  if (filteredApps.length > 28)
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          (filteredApps.length / 28).ceil(),
                          (index) => Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

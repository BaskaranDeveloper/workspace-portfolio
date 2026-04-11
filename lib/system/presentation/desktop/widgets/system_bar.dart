import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:workspace/system/presentation/utils/full_screen_manager.dart';
import 'package:workspace/system/presentation/desktop/widgets/status_indicators/battery_indicator.dart';
import 'package:workspace/system/presentation/desktop/widgets/status_indicators/network_indicator.dart';
import 'package:workspace/system/presentation/desktop/widgets/system_menu.dart';
import 'package:workspace/system/presentation/boot/widgets/mac_logo.dart';

class SystemBar extends StatefulWidget {
  final VoidCallback? onControlCenterTap;

  const SystemBar({super.key, this.onControlCenterTap});

  @override
  State<SystemBar> createState() => _SystemBarState();
}

class _SystemBarState extends State<SystemBar> {
  late Timer _timer;
  late String _timeString;

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _getTime(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _getTime() {
    final String formattedDateTime = _formatDateTime(DateTime.now());
    if (mounted) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('E MMM d  HH:mm').format(dateTime);
  }

  void _toggleFullScreen() {
    setState(() {
      FullScreenManager.toggleFullScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: LiquidGlass(
        borderRadius: 24,
        height: 38,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Menus
            Expanded(
              child: Row(
                children: [
                  const MacLogo(size: 16, color: Colors.white),
                  const SizedBox(width: 20),
                  const Text(
                    'Workspace',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SystemMenu(
                            label: 'File',
                            entries: [
                              MenuItem(label: 'New Window', onTap: () {}),
                              MenuItem(label: 'New Folder', onTap: () {}),
                              MenuDivider(),
                              MenuItem(label: 'Close', onTap: () {}),
                            ],
                          ),
                          SystemMenu(
                            label: 'Edit',
                            entries: [
                              MenuItem(label: 'Undo', onTap: () {}),
                              MenuItem(label: 'Redo', onTap: () {}),
                              MenuDivider(),
                              MenuItem(label: 'Cut', onTap: () {}),
                              MenuItem(label: 'Copy', onTap: () {}),
                              MenuItem(label: 'Paste', onTap: () {}),
                            ],
                          ),
                          SystemMenu(
                            label: 'View',
                            entries: [
                              MenuItem(
                                label: 'Toggle Full Screen',
                                onTap: _toggleFullScreen,
                              ),
                            ],
                          ),
                          SystemMenu(
                            label: 'Go',
                            entries: [
                              MenuItem(label: 'Back', onTap: () {}),
                              MenuItem(label: 'Forward', onTap: () {}),
                            ],
                          ),
                          SystemMenu(
                            label: 'Window',
                            entries: [
                              MenuItem(label: 'Minimize', onTap: () {}),
                              MenuItem(label: 'Zoom', onTap: () {}),
                            ],
                          ),
                          SystemMenu(
                            label: 'Help',
                            entries: [
                              MenuItem(
                                label: 'About Workspace',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right: Status
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, // Scroll from right
                child: Row(
                  children: [
                    // Full Screen Toggle
                    GestureDetector(
                      onTap: _toggleFullScreen,
                      child: Icon(
                        FullScreenManager.isFullScreen
                            ? LucideIcons.minimize
                            : LucideIcons.maximize,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Battery
                    const BatteryIndicator(),
                    const SizedBox(width: 16),

                    // Network
                    const NetworkIndicator(),
                    const SizedBox(width: 16),

                    // Search
                    const Icon(LucideIcons.search, color: Colors.white, size: 18),
                    const SizedBox(width: 16),

                    // Control Center
                    GestureDetector(
                      onTap: widget.onControlCenterTap,
                      child: const Icon(
                        LucideIcons.slidersHorizontal,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Clock
                    Text(
                      _timeString,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

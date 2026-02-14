import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workspace/presentation/system/utils/full_screen_manager.dart';
import 'package:workspace/presentation/system/desktop/widgets/status_indicators/battery_indicator.dart';
import 'package:workspace/presentation/system/desktop/widgets/status_indicators/network_indicator.dart';
import 'package:workspace/presentation/system/desktop/widgets/system_menu.dart';

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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 28,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: Menus
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.apple, color: Colors.white, size: 18),
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
              Row(
                children: [
                  // Full Screen Toggle
                  GestureDetector(
                    onTap: _toggleFullScreen,
                    child: Icon(
                      FullScreenManager.isFullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
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
                  const Icon(Icons.search, color: Colors.white, size: 18),
                  const SizedBox(width: 16),

                  // Control Center
                  GestureDetector(
                    onTap: widget.onControlCenterTap,
                    child: const Icon(
                      Icons.control_camera,
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
            ],
          ),
        ),
      ),
    );
  }
}

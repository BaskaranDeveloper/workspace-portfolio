import 'dart:ui';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:js' as js;

import 'package:intl/intl.dart';

class SystemBar extends StatefulWidget {
  const SystemBar({super.key});

  @override
  State<SystemBar> createState() => _SystemBarState();
}

class _SystemBarState extends State<SystemBar> {
  late Timer _timer;
  late String _timeString;
  bool _isFullScreen = false;

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
    try {
      if (_isFullScreen) {
        js.context.callMethod('eval', [
          'if (document.exitFullscreen) { document.exitFullscreen(); } else if (document.webkitExitFullscreen) { document.webkitExitFullscreen(); } else if (document.msExitFullscreen) { document.msExitFullscreen(); }',
        ]);
      } else {
        js.context.callMethod('eval', [
          'const el = document.documentElement; if (el.requestFullscreen) { el.requestFullscreen(); } else if (el.webkitRequestFullscreen) { el.webkitRequestFullscreen(); } else if (el.msRequestFullscreen) { el.msRequestFullscreen(); }',
        ]);
      }
      setState(() {
        _isFullScreen = !_isFullScreen;
      });
    } catch (e) {
      debugPrint('Error toggling full screen: $e');
    }
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
            color: Colors.black.withOpacity(0.2),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.1),
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
                            _buildMenuText('File'),
                            _buildMenuText('Edit'),
                            _buildMenuText('View'),
                            _buildMenuText('Go'),
                            _buildMenuText('Window'),
                            _buildMenuText('Help'),
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
                  GestureDetector(
                    onTap: _toggleFullScreen,
                    child: Icon(
                      _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.battery_full, color: Colors.white, size: 18),
                  const SizedBox(width: 16),
                  const Icon(Icons.wifi, color: Colors.white, size: 18),
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: Colors.white, size: 18),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.control_camera,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 16),
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

  Widget _buildMenuText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

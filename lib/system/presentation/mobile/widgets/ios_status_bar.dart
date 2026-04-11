import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:async';

class IOSStatusBar extends StatefulWidget {
  const IOSStatusBar({super.key});

  @override
  State<IOSStatusBar> createState() => _IOSStatusBarState();
}

class _IOSStatusBarState extends State<IOSStatusBar> {
  late Timer _timer;
  late String _timeString;

  @override
  void initState() {
    super.initState();
    _timeString = _formatTime(DateTime.now());
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
    final String formattedDateTime = _formatTime(DateTime.now());
    if (mounted && _timeString != formattedDateTime) {
      setState(() {
        _timeString = formattedDateTime;
      });
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour == 0
        ? 12
        : time.hour > 12
        ? time.hour - 12
        : time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // Standard iOS Status Bar Height ~44-48px usually handled by SafeArea,
    // but here we render content within that space.
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Time (Left)
            Text(
              _timeString,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily:
                    'Roboto', // Using Roboto as Inter/SF might not be loaded, mimics clean sans
                letterSpacing: -0.5,
              ),
            ),

            // Icons (Right)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.menu, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                const Icon(LucideIcons.wifi, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                const Icon(
                  LucideIcons.batteryFull,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

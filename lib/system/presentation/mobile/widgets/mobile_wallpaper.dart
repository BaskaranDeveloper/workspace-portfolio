import 'package:flutter/material.dart';

class MobileWallpaper extends StatelessWidget {
  const MobileWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2E1065), // Deep Purple
            Color(0xFFdb2777), // Pink
            Color(0xFFf472b6), // Light Pink
            Color(0xFFa855f7), // Purple
            Color(0xFF3b82f6), // Blue
          ],
          stops: [0.0, 0.3, 0.5, 0.7, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.2),
              Colors.transparent,
              Colors.black.withValues(alpha: 0.4),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BootProgressBar extends StatelessWidget {
  final double progress;
  const BootProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Fixed width for macOS style
      height: 4,  // Slightly thicker for visibility on black
      decoration: BoxDecoration(
        color: const Color(0xFF333333), // Dark grey background
        borderRadius: BorderRadius.circular(2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // White progress
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

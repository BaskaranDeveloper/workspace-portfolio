import 'package:flutter/material.dart';

class DockItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double size;
  final Duration duration;

  final bool isActive;

  const DockItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.size,
    required this.duration,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Tooltip(
            message: label,
            child: AnimatedContainer(
              duration: duration,
              curve: duration == Duration.zero ? Curves.linear : Curves.easeOut,
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: size * 0.5),
            ),
          ),
        ),
        const SizedBox(height: 4),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isActive ? 1.0 : 0.0,
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

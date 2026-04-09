import 'package:flutter/material.dart';

class DockItem extends StatelessWidget {
  final IconData icon;
  final String? iconPath;
  final String label;
  final Color color;
  final double size;
  final Duration duration;

  final bool isActive;

  const DockItem({
    super.key,
    required this.icon,
    this.iconPath,
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
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Tooltip(
            message: label,
            child: AnimatedContainer(
              duration: duration,
              curve: duration == Duration.zero ? Curves.linear : Curves.easeOut,
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.9), // Always use theme color for tile
                borderRadius: BorderRadius.circular(size * 0.22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 1,
                    spreadRadius: -1,
                    offset: const Offset(0, 1), // Inner light
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size * 0.22),
                child: iconPath != null
                    ? Image.asset(
                        iconPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(icon, color: Colors.white, size: size * 0.5),
                      )
                    : Icon(icon, color: Colors.white, size: size * 0.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isActive ? 1.0 : 0.0,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

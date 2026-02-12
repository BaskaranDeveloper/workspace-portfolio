import 'package:flutter/material.dart';

class DockItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double size; // Now receives size directly from parent
  final Duration duration; // Animation duration

  const DockItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.size,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: size * 0.5),
        ),
      ),
    );
  }
}

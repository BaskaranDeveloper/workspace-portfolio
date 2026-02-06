import 'package:flutter/material.dart';

class DockItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isHovered;
  final VoidCallback onHover;
  final VoidCallback onExit;

  const DockItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isHovered,
    required this.onHover,
    required this.onExit,
  });

  @override
  State<DockItem> createState() => _DockItemState();
}

class _DockItemState extends State<DockItem> {
  @override
  Widget build(BuildContext context) {
    // 1. MouseRegion detects hover events

    return MouseRegion(
      onEnter: (_) => widget.onHover(),
      onExit: (_) => widget.onExit(),
      child: Tooltip(
        message: widget.label,
        // 2. AnimatedContainer handles the smooth effect scalling
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: widget.isHovered ? 55 : 45,
          height: widget.isHovered ? 55 : 45,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: Colors.white,
            // Scale the icon when hovered
            size: widget.isHovered ? 30 : 24,
          ),
        ),
      ),
    );
  }
}

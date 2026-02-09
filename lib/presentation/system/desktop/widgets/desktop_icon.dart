import 'package:flutter/material.dart';
import '../models/desktop_item.dart';

class DesktopIcon extends StatelessWidget {
  final DesktopItem item;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final Function(Offset newPosition) onDragEnd;

  const DesktopIcon({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDoubleTap,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: item.position.dx,
      top: item.position.dy,
      child: GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        child: Draggable<DesktopItem>(
          data: item,
          feedback: Material(
            color: Colors.transparent,
            child: _buildContent(isDragging: true),
          ),
          childWhenDragging: Opacity(opacity: 0.5, child: _buildContent()),
          onDragEnd: (details) {
            // details.offset gives the global position where the drag ended
            onDragEnd(details.offset);
          },
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent({bool isDragging = false}) {
    return Container(
      width: 80,
      height: 90,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.isSelected ? Colors.white.withOpacity(0.2) : null,
              borderRadius: BorderRadius.circular(8),
              border: item.isSelected
                  ? Border.all(color: Colors.white.withOpacity(0.3))
                  : null,
            ),
            child: Icon(item.icon, size: 40, color: item.color),
          ),
          const SizedBox(height: 4),
          if (!isDragging)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: item.isSelected ? Colors.blueAccent : null,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                item.label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

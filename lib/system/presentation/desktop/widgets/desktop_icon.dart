import 'package:flutter/material.dart';
import '../models/desktop_item.dart';

class DesktopIcon extends StatefulWidget {
  final DesktopItem item;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback? onSecondaryTap;
  final Function(Offset newPosition) onDragEnd;

  const DesktopIcon({
    super.key,
    required this.item,
    required this.onTap,
    required this.onDoubleTap,
    this.onSecondaryTap,
    required this.onDragEnd,
  });

  @override
  State<DesktopIcon> createState() => _DesktopIconState();
}

class _DesktopIconState extends State<DesktopIcon> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.item.position.dx,
      top: widget.item.position.dy,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onSecondaryTap: widget.onSecondaryTap,
          child: Draggable<DesktopItem>(
            data: widget.item,
            feedback: Material(
              color: Colors.transparent,
              child: _buildContent(isDragging: true),
            ),
            childWhenDragging: Opacity(opacity: 0.5, child: _buildContent()),
            onDragEnd: (details) {
              widget.onDragEnd(details.offset);
            },
            child: AnimatedScale(
              scale: _isHovering ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent({bool isDragging = false}) {
    final bool hasImage = widget.item.iconPath != null;

    return Container(
      width: 80,
      height: 100,
      color: Colors.transparent,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60,
            height: 60,
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              color: widget.item.isSelected
                  ? Colors.blue.withValues(alpha: 0.3)
                  : _isHovering
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.transparent,
              shadows: _isHovering && !isDragging
                  ? [
                      BoxShadow(
                        color: (hasImage ? Colors.black : widget.item.color)
                            .withValues(alpha: 0.25),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : widget.item.isSelected 
                      ? [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.3),
                            blurRadius: 10,
                          )
                        ]
                      : null,
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: hasImage
                  ? Image.asset(
                      widget.item.iconPath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        widget.item.icon,
                        size: 32,
                        color: widget.item.color,
                      ),
                    )
                  : Center(
                      child: Icon(
                        widget.item.icon,
                        size: 32,
                        color: widget.item.color,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          if (!isDragging)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: widget.item.isSelected 
                    ? Colors.blue.withValues(alpha: 0.6) 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                widget.item.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black87,
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }
}

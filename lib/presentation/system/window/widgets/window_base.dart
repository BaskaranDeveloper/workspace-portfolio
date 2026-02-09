import 'package:flutter/material.dart';
import '../models/window_model.dart';

class WindowBase extends StatefulWidget {
  final WindowModel window;
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final Function(Offset newPos) onDrag;
  final VoidCallback onFocus;

  const WindowBase({
    super.key,
    required this.window,
    required this.onClose,
    required this.onMinimize,
    required this.onMaximize,
    required this.onDrag,
    required this.onFocus,
  });

  @override
  State<WindowBase> createState() => _WindowBaseState();
}

class _WindowBaseState extends State<WindowBase> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.window.position.dx,
      top: widget.window.position.dy,
      width: widget.window.size.width,
      height: widget.window.size.height,
      child: GestureDetector(
        onTapDown: (_) => widget.onFocus(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Title Bar
              GestureDetector(
                onPanUpdate: (details) {
                  final newPos = widget.window.position + details.delta;
                  widget.onDrag(newPos);
                },
                child: Container(
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDECEB),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      _buildBtn(Colors.red[400]!, widget.onClose),
                      const SizedBox(width: 8),
                      _buildBtn(Colors.amber[400]!, widget.onMinimize),
                      const SizedBox(width: 8),
                      _buildBtn(Colors.green[400]!, widget.onMaximize),
                      Expanded(
                        child: Text(
                          widget.window.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
              ),
              // Content
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                  child: widget.window.content,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBtn(Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}

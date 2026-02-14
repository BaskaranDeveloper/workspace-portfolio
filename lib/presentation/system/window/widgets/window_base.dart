import 'package:flutter/material.dart';
import '../models/window_model.dart';

class WindowBase extends StatefulWidget {
  final WindowModel window;
  final VoidCallback onClose;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final Function(Offset newPos) onDrag;
  final VoidCallback onFocus;
  final Function(Size newSiz) onResize;

  const WindowBase({
    super.key,
    required this.window,
    required this.onClose,
    required this.onMinimize,
    required this.onMaximize,
    required this.onDrag,
    required this.onFocus,
    required this.onResize,
  });

  @override
  State<WindowBase> createState() => _WindowBaseState();
}

class _WindowBaseState extends State<WindowBase>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Slightly longer for flow
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 30), // Start slightly below
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuint));

    _controller.forward();
  }

  //  Handle the closing animation
  void _handleClose() async {
    await _controller.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMaximized = widget.window.isMaximized;

    // Calculate render properties
    final double currentWidth = isMaximized
        ? screenSize.width
        : widget.window.size.width;

    final double currentHeight = isMaximized
        ? screenSize.height
        : widget.window.size.height;

    final double currentTop = isMaximized ? 0 : widget.window.position.dy;

    final double currentLeft = isMaximized ? 0 : widget.window.position.dx;
    return Positioned(
      left: currentLeft,
      top: currentTop,
      width: currentWidth,
      height: currentHeight,
      child: GestureDetector(
        onTapDown: (_) => widget.onFocus(),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: _slideAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              ),
            );
          },
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
            child: Stack(
              children: [
                Column(
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
                            _buildBtn(Colors.red[400]!, _handleClose),
                            const SizedBox(width: 8),
                            _buildBtn(Colors.amber[400]!, widget.onMinimize),
                            const SizedBox(width: 8),
                            _buildBtn(Colors.green[400]!, widget.onMaximize),
                            Expanded(
                              child: Text(
                                widget.window.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
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
                // Resize Handle
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final newWidth =
                          widget.window.size.width + details.delta.dx;
                      final newHeight =
                          widget.window.size.height + details.delta.dy;
                      widget.onResize(Size(newWidth, newHeight));
                    },
                    child: Container(
                      width: 20,
                      height: 20,
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.north_west,
                        size: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

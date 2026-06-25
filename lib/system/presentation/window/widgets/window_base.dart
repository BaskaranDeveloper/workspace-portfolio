import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';
import '../models/window_model.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

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

class _WindowBaseState extends State<WindowBase> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0, curve: Curves.easeOut)));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

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

    final double currentWidth = isMaximized ? screenSize.width : widget.window.size.width;
    final double currentHeight = isMaximized ? screenSize.height : widget.window.size.height;
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
            final double animValue = _controller.value;
            return IgnorePointer(
              ignoring: animValue < 0.9,
              child: Transform.translate(
                offset: _slideAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: LiquidGlass(
            borderRadius: 24,
            intensity: 0.9,
            shadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 40,
                spreadRadius: -5,
                offset: const Offset(0, 20),
              ),
            ],
            child: Stack(
              children: [
                Column(
                  children: [
                    // macOS Style Title Bar
                    GestureDetector(
                      onPanUpdate: (details) {
                        if (!isMaximized) {
                          widget.onDrag(widget.window.position + details.delta);
                        }
                      },
                      onDoubleTap: widget.onMaximize,
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.05),
                          border: const Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            _buildBtn(const Color(0xFFFF5F56), _handleClose),
                            const SizedBox(width: 8),
                            _buildBtn(const Color(0xFFFFBD2E), widget.onMinimize),
                            const SizedBox(width: 8),
                            _buildBtn(const Color(0xFF27C93F), widget.onMaximize),
                            Expanded(
                              child: Text(
                                widget.window.title,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 60),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.backgroundPrimary.withValues(alpha: 0.4),
                        child: widget.window.content,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final newWidth = widget.window.size.width + details.delta.dx;
                      final newHeight = widget.window.size.height + details.delta.dy;
                      widget.onResize(Size(newWidth.clamp(200.0, 2000.0), newHeight.clamp(100.0, 2000.0)));
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      color: Colors.transparent,
                      child: Center(child: Icon(LucideIcons.expand, size: 10, color: Colors.white.withValues(alpha: 0.3))),
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
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black.withValues(alpha: 0.1), width: 0.5),
          ),
        ),
      ),
    );
  }
}

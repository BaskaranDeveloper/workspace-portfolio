import 'dart:math' as math;
import 'package:flutter/material.dart';

class HUDDecorator extends StatefulWidget {
  final Widget child;
  final String? label;
  final String? subLabel;
  final bool showScanLine;
  final Color? accentColor;
  final List<HUDCoordinate>? coordinates;

  const HUDDecorator({
    super.key,
    required this.child,
    this.label,
    this.subLabel,
    this.showScanLine = true,
    this.accentColor,
    this.coordinates,
  });

  @override
  State<HUDDecorator> createState() => _HUDDecoratorState();
}

class _HUDDecoratorState extends State<HUDDecorator> with SingleTickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? const Color(0xFF38BDF8);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          widget.child,

          // SCAN LINE
          if (widget.showScanLine)
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return AnimatedBuilder(
                    animation: _scanController,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          Positioned(
                            top: _scanController.value * constraints.maxHeight,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    accent.withValues(alpha: 0.0),
                                    accent.withValues(alpha: 0.15),
                                    accent.withValues(alpha: 0.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),

          // CORNER COORDINATES & ORNAMENTATION
          Positioned.fill(
            child: PointerInterceptor(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _HUDOrnamentPainter(
                    accent: accent,
                    label: widget.label,
                    subLabel: widget.subLabel,
                    coordinates: widget.coordinates,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HUDCoordinate {
  final String label;
  final Alignment alignment;
  HUDCoordinate(this.label, this.alignment);
}

class _HUDOrnamentPainter extends CustomPainter {
  final Color accent;
  final String? label;
  final String? subLabel;
  final List<HUDCoordinate>? coordinates;

  _HUDOrnamentPainter({
    required this.accent,
    this.label,
    this.subLabel,
    this.coordinates,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Drawing Corner Brackets (HUD Look)
    const double l = 15.0;
    const double d = 2.0;

    // NW
    canvas.drawLine(const Offset(d, d), const Offset(d + l, d), paint);
    canvas.drawLine(const Offset(d, d), const Offset(d, d + l), paint);

    // SE
    canvas.drawLine(Offset(size.width - d, size.height - d), Offset(size.width - d - l, size.height - d), paint);
    canvas.drawLine(Offset(size.width - d, size.height - d), Offset(size.width - d, size.height - d - l), paint);

    // Draw Labels if present
    if (label != null) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: label!.toUpperCase(),
          style: TextStyle(
            color: accent.withValues(alpha: 0.4),
            fontSize: 8,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, const Offset(d + l + 8, d));
    }

    // Draw coordinates
    if (coordinates != null) {
      for (var coord in coordinates!) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: coord.label.toUpperCase(),
            style: TextStyle(
              color: Colors.white10,
              fontSize: 7,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        
        final offset = coord.alignment.alongSize(size);
        final adjustedOffset = Offset(
          coord.alignment.x < 0 ? offset.dx + 4 : offset.dx - textPainter.width - 4,
          coord.alignment.y < 0 ? offset.dy + 4 : offset.dy - textPainter.height - 4,
        );
        textPainter.paint(canvas, adjustedOffset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HUDOrnamentPainter oldDelegate) => false;
}

// Simple helper for mouse events on non-interactive layers
class PointerInterceptor extends StatelessWidget {
  final Widget child;
  const PointerInterceptor({super.key, required this.child});
  @override
  Widget build(BuildContext context) => child;
}

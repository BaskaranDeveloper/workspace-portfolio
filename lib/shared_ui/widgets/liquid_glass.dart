import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurSigma;
  final Color? tintColor;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.blurSigma = 60.0,
    this.tintColor,
    this.shadows,
    this.width,
    this.height,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Stack(
            children: [
              // Layer 1: Glass Texture (Grain)
              Positioned.fill(
                child: CustomPaint(
                  painter: _GlassTexturePainter(opacity: 0.03),
                ),
              ),
              // Layer 2: Core Refraction Gradient
              Positioned.fill(
                child: Container(
                  padding: padding,
                  alignment: alignment,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.15), // Specular light (top)
                        Colors.white.withValues(alpha: 0.05), // Natural transparency
                        Colors.black.withValues(alpha: 0.02), // Dark core
                        Colors.white.withValues(alpha: 0.1),  // Specular rim (bottom)
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 0.5,
                    ),
                  ),
                  child: child,
                ),
              ),
              // Layer 3: Specular Bevel Highlight (Corners)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _SpecularBevelPainter(
                      borderRadius: borderRadius,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Paints a subtle procedural noise/grain on the glass surface.
class _GlassTexturePainter extends CustomPainter {
  final double opacity;
  _GlassTexturePainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: opacity);
    final random = Random(42); // Seeded for consistency
    
    for (int i = 0; i < 1000; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawRect(Rect.fromLTWH(x, y, 1, 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Paints a sharp specular highlight that accents the curved edges/corners.
class _SpecularBevelPainter extends CustomPainter {
  final double borderRadius;
  final Color color;

  _SpecularBevelPainter({required this.borderRadius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
        Radius.circular(borderRadius),
      ));

    // Clip to show only top-left and bottom-right specular highlights
    canvas.save();
    canvas.clipPath(Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.4, 0)
      ..lineTo(0, size.height * 0.4)
      ..close());
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

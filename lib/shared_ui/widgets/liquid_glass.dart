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
  final ShapeBorder? shape;
  final double intensity; // 0.0 to 1.0, scales effects

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
    this.shape,
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShape = shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        );

    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: effectiveShape,
        shadows: shadows ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(shape: effectiveShape),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Stack(
            children: [
              // Layer 0: Optional Tint
              if (tintColor != null)
                Positioned.fill(
                  child: Container(
                    color: tintColor!.withValues(alpha: 0.12 * intensity),
                  ),
                ),
              // Layer 1: Volumetric Deep Gradient (Simulates thickness)
              Positioned.fill(
                child: Container(
                  decoration: ShapeDecoration(
                    shape: effectiveShape,
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.5,
                      colors: [
                        Colors.white.withValues(alpha: 0.1 * intensity),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.05 * intensity),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Layer 2: Core Refraction & Ambient Rim
              Positioned.fill(
                child: Container(
                  padding: padding,
                  alignment: alignment,
                  decoration: ShapeDecoration(
                    shape: effectiveShape,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.22 * intensity), // Top specular light
                        Colors.white.withValues(alpha: 0.04 * intensity), // Natural transparency
                        Colors.black.withValues(alpha: 0.04 * intensity), // Dark core depth
                        Colors.white.withValues(alpha: 0.15 * intensity), // Bottom specular rim
                      ],
                      stops: const [0.0, 0.35, 0.75, 1.0],
                    ),
                  ),
                  child: child,
                ),
              ),
              // Layer 4: Prismatic Rim (Chromatic Aberration simulation)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _PrismaticRimPainter(
                      shape: effectiveShape,
                      intensity: intensity,
                    ),
                  ),
                ),
              ),
              // Layer 5: Multi-Layer Specular Bevel Highlights
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _SpecularBevelPainter(
                      shape: effectiveShape,
                      color: Colors.white.withValues(alpha: 0.3 * intensity),
                      bloomIntensity: 0.5 * intensity,
                    ),
                  ),
                ),
              ),
              // Layer 6: Polished Inner Rim (Subtle physical border)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: (effectiveShape is OutlinedBorder)
                          ? (effectiveShape as OutlinedBorder).copyWith(
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.2 * intensity),
                                width: 0.75,
                              ),
                            )
                          : effectiveShape,
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

/// Paints a multi-layered specular highlight that accents the curved edges/corners with bloom.
class _SpecularBevelPainter extends CustomPainter {
  final ShapeBorder shape;
  final Color color;
  final double bloomIntensity;

  _SpecularBevelPainter({
    required this.shape,
    required this.color,
    this.bloomIntensity = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);
    final path = shape.getOuterPath(rect);

    // Pass 1: Core Sharp Highlight
    final paintSharp = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

    // Pass 2: Soft Bloom Highlight
    final paintBloom = Paint()
      ..color = color.withValues(alpha: color.a * bloomIntensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.5);

    // Clip to show only top-left and bottom-right specular areas
    canvas.save();
    canvas.clipPath(Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.45, 0)
      ..lineTo(0, size.height * 0.45)
      ..close());
    canvas.drawPath(path, paintBloom);
    canvas.drawPath(path, paintSharp);
    canvas.restore();

    canvas.save();
    canvas.clipPath(Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 0.55, size.height)
      ..lineTo(size.width, size.height * 0.55)
      ..close());
    canvas.drawPath(path, paintBloom);
    canvas.drawPath(path, paintSharp);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SpecularBevelPainter oldDelegate) =>
      oldDelegate.shape != shape ||
      oldDelegate.color != color ||
      oldDelegate.bloomIntensity != bloomIntensity;
}

/// Paints a subtle prismatic rim (chromatic aberration) at the edges.
class _PrismaticRimPainter extends CustomPainter {
  final ShapeBorder shape;
  final double intensity;

  _PrismaticRimPainter({required this.shape, required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity < 0.1) return;

    final rect = Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1);
    final path = shape.getOuterPath(rect);

    void drawLayer(Color color, Offset offset) {
      final paint = Paint()
        ..color = color.withValues(alpha: 0.15 * intensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.5);

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }

    // Cyan/Red shift for chromatic aberration
    drawLayer(Colors.cyan, const Offset(-0.3, -0.3));
    drawLayer(Colors.redAccent, const Offset(0.3, 0.3));
  }

  @override
  bool shouldRepaint(covariant _PrismaticRimPainter oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.intensity != intensity;
}

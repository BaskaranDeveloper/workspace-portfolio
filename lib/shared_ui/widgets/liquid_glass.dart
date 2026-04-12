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
  final bool holographic; // Adds an iridescent sheen layer
  final bool showGrain;   // Adds physical noise texture
  final bool animatedRim; // Enables a circulating light path

  const LiquidGlass({
    super.key,
    required this.child,
    this.borderRadius = 24.0,
    this.blurSigma = 32.0,
    this.tintColor,
    this.shadows,
    this.width,
    this.height,
    this.padding,
    this.alignment,
    this.shape,
    this.intensity = 1.0,
    this.holographic = false,
    this.showGrain = true,
    this.animatedRim = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShape = shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        );

    final widgetStack = Stack(
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
        // Layer 2: Core Refraction & Ambient Rim (Base layer for Stack sizing)
        Container(
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
        // Layer 7: Holographic Iridescence
        if (holographic)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: ShapeDecoration(
                  shape: effectiveShape,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan.withValues(alpha: 0.03 * intensity),
                      Colors.transparent,
                      Colors.purpleAccent.withValues(alpha: 0.03 * intensity),
                      Colors.transparent,
                      Colors.yellow.withValues(alpha: 0.03 * intensity),
                    ],
                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),
          ),
        // Layer 8: Physical Grain Texture
        if (showGrain)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _GrainPainter(intensity: intensity),
              ),
            ),
          ),
        if (animatedRim)
          Positioned.fill(
            child: IgnorePointer(
              child: _AnimatedSpecularRim(
                shape: effectiveShape,
                intensity: intensity,
              ),
            ),
          ),
      ],
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
      child: _buildClipper(
        shape: effectiveShape,
        child: RepaintBoundary(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: widgetStack,
          ),
        ),
      ),
    );
  }

  /// High-performance clipping strategy to avoid hit-test errors on Web.
  Widget _buildClipper({required ShapeBorder shape, required Widget child}) {
    if (shape is RoundedRectangleBorder) {
      return ClipRRect(
        borderRadius: shape.borderRadius as BorderRadius,
        child: child,
      );
    }
    return ClipPath(
      clipper: ShapeBorderClipper(shape: shape),
      child: child,
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

/// A high-performance grain/noise painter that simulates physical glass texture.
class _GrainPainter extends CustomPainter {
  final double intensity;
  final Random _random = Random(42);

  _GrainPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity < 0.05) return;

    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04 * intensity)
      ..strokeWidth = 0.8
      ..strokeCap = StrokeCap.round;

    // High-performance point drawing (Fixed count for stability)
    final List<Offset> points = [];
    const int count = 1200; // Fixed count is much faster than area-based loops on Web
    for (int i = 0; i < count; i++) {
      points.add(Offset(_random.nextDouble() * size.width, _random.nextDouble() * size.height));
    }

    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => oldDelegate.intensity != intensity;
}

/// A stateful component that sweeps a specular highlight around the rim of a shape.
class _AnimatedSpecularRim extends StatefulWidget {
  final ShapeBorder shape;
  final double intensity;

  const _AnimatedSpecularRim({required this.shape, required this.intensity});

  @override
  State<_AnimatedSpecularRim> createState() => _AnimatedSpecularRimState();
}

class _AnimatedSpecularRimState extends State<_AnimatedSpecularRim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _RimSweepPainter(
            shape: widget.shape,
            intensity: widget.intensity,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

class _RimSweepPainter extends CustomPainter {
  final ShapeBorder shape;
  final double intensity;
  final double progress;

  _RimSweepPainter({required this.shape, required this.intensity, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1);
    final path = shape.getOuterPath(rect);

    final p0 = (progress - 0.1).clamp(0.0, 0.98);
    final p1 = progress.clamp(0.01, 0.99);
    final p2 = (progress + 0.1).clamp(0.02, 1.0);

    final gradient = SweepGradient(
      center: Alignment.center,
      startAngle: 0,
      endAngle: 2 * pi,
      colors: [
        Colors.transparent,
        Colors.white.withValues(alpha: 0.15 * intensity),
        Colors.transparent,
      ],
      stops: [p0, p1, p2],
      transform: GradientRotation(progress * 2 * pi),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _RimSweepPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.intensity != intensity;
}

import 'dart:math' as math;
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
  final Color? accentColor; // The signature theme color for the topic

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
    this.accentColor,
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
                center: const Alignment(-0.8, -0.8),
                radius: 1.5,
                colors: [
                  Colors.white.withValues(alpha: 0.12 * intensity),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.08 * intensity),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        // Layer 2: Core Refraction & Ambient Rim
        Container(
          padding: padding,
          alignment: alignment,
          decoration: ShapeDecoration(
            shape: effectiveShape,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.20 * intensity), 
                Colors.white.withValues(alpha: 0.04 * intensity), 
                Colors.black.withValues(alpha: 0.04 * intensity), 
                Colors.white.withValues(alpha: 0.12 * intensity), 
              ],
              stops: const [0.0, 0.35, 0.75, 1.0],
            ),
          ),
          child: child,
        ),
        // Layer 4: Prismatic Rim (Subtle chromatic aberration)
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _PrismaticRimPainter(
                shape: effectiveShape,
                intensity: intensity,
                accentColor: accentColor ?? Colors.white54,
              ),
            ),
          ),
        ),
        // Layer 5: Specular Bevel Highlights
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _SpecularBevelPainter(
                shape: effectiveShape,
                color: (accentColor ?? Colors.white).withValues(alpha: 0.25 * intensity),
                bloomIntensity: 0.4 * intensity,
              ),
            ),
          ),
        ),
        // Layer 6: Polished Inner Rim
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: ShapeDecoration(
                shape: (effectiveShape is OutlinedBorder)
                    ? (effectiveShape as OutlinedBorder).copyWith(
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.15 * intensity),
                          width: 0.5,
                        ),
                      )
                    : effectiveShape,
              ),
            ),
          ),
        ),
        // Layer 7: Subtle Iridescence (Holographic v3.1 Native)
        if (holographic == true)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedContainer(
                duration: const Duration(seconds: 6),
                decoration: ShapeDecoration(
                  shape: effectiveShape,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.cyan.withValues(alpha: 0.05 * intensity),
                      Colors.transparent,
                      Colors.purpleAccent.withValues(alpha: 0.05 * intensity),
                      Colors.transparent,
                      Colors.white.withValues(alpha: 0.03 * intensity),
                      Colors.transparent,
                      Colors.blueAccent.withValues(alpha: 0.05 * intensity),
                    ],
                    stops: const [0.0, 0.2, 0.4, 0.6, 0.8, 0.9, 1.0],
                  ),
                ),
              ),
            ),
          ),
        // Layer 8: Physical Grain (Native Texture)
        if (showGrain == true)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _GrainPainter(intensity: intensity),
              ),
            ),
          ),
        if (animatedRim == true)
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
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 30,
                offset: const Offset(0, 15),
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

    final paintSharp = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final paintBloom = Paint()
      ..color = color.withValues(alpha: color.a * bloomIntensity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    canvas.save();
    canvas.clipPath(Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.4, 0)
      ..lineTo(0, size.height * 0.4)
      ..close());
    canvas.drawPath(path, paintBloom);
    canvas.drawPath(path, paintSharp);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SpecularBevelPainter oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.color != color;
}

class _PrismaticRimPainter extends CustomPainter {
  final ShapeBorder shape;
  final double intensity;
  final Color accentColor;

  _PrismaticRimPainter({required this.shape, required this.intensity, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity < 0.1) return;
    final rect = Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1);
    final path = shape.getOuterPath(rect);

    void drawLayer(Color color, Offset offset) {
      final paint = Paint()
        ..color = color.withValues(alpha: 0.1 * intensity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }

    drawLayer(accentColor, const Offset(-0.2, -0.2));
  }

  @override
  bool shouldRepaint(covariant _PrismaticRimPainter oldDelegate) => false;
}

class _GrainPainter extends CustomPainter {
  final double intensity;
  final math.Random _random = math.Random(42);

  _GrainPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03 * intensity)
      ..strokeWidth = 0.5;

    final List<Offset> points = [];
    const int count = 800;
    for (int i = 0; i < count; i++) {
        points.add(Offset(_random.nextDouble() * size.width, _random.nextDouble() * size.height));
    }
    canvas.drawPoints(PointMode.points, points, paint);
  }

  @override
  bool shouldRepaint(covariant _GrainPainter oldDelegate) => false;
}

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
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5))..repeat();
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
      builder: (context, child) => CustomPaint(
        painter: _RimSweepPainter(shape: widget.shape, intensity: widget.intensity, progress: _controller.value),
      ),
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
    final gradient = SweepGradient(
      center: Alignment.center,
      colors: [Colors.transparent, Colors.white.withValues(alpha: 0.1 * intensity), Colors.transparent],
      stops: [0.0, 0.5, 1.0],
      transform: GradientRotation(progress * 2 * math.pi),
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant _RimSweepPainter oldDelegate) => true;
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class ParallaxBackground extends StatefulWidget {
  final Widget? child;
  const ParallaxBackground({super.key, this.child});

  @override
  State<ParallaxBackground> createState() => _ParallaxBackgroundState();
}

class _ParallaxBackgroundState extends State<ParallaxBackground> {
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Calculate maximum displacement based on screen size
    final double maxDisplacementX = size.width * 0.05; // 5% of screen
    final double maxDisplacementY = size.height * 0.05;

    // Map mouse position to -1.0 to 1.0 range
    final double normalizedX = _mousePos.dx == 0 ? 0 : (_mousePos.dx - centerX) / centerX;
    final double normalizedY = _mousePos.dy == 0 ? 0 : (_mousePos.dy - centerY) / centerY;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePos = event.position;
        });
      },
      onExit: (event) {
        // Optional: smoothly return to center
      },
      child: Stack(
        children: [
          // Base Deep Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.backgroundDark,
                  AppColors.backgroundSecondary,
                  AppColors.backgroundTertiary,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
          
          // Layer 1: Distant glowing orb (slow moving)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            left: (size.width * 0.6) - (normalizedX * maxDisplacementX * 0.3),
            top: (size.height * 0.2) - (normalizedY * maxDisplacementY * 0.3),
            child: _buildOrb(400, AppColors.terminalBlue.withValues(alpha: 0.15)),
          ),
          
          // Layer 2: Closer glowing orb (fast moving)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            left: (size.width * 0.1) - (normalizedX * maxDisplacementX * 0.8),
            bottom: (size.height * 0.1) - (normalizedY * maxDisplacementY * 0.8),
            child: _buildOrb(600, const Color(0xFF6D28D9).withValues(alpha: 0.12)), // Purple hue
          ),
          
          // Overall Noise / Backdrop blur to blend everything
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          
          // Children (Desktop gesture detector & items)
          if (widget.child != null)
            Positioned.fill(child: widget.child!),
        ],
      ),
    );
  }

  Widget _buildOrb(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 100,
            spreadRadius: 50,
          )
        ]
      ),
    );
  }
}

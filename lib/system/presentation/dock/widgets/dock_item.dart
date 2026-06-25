import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/widgets/liquid_glass.dart';

class DockItem extends StatelessWidget {
  final IconData icon;
  final String? iconPath;
  final String label;
  final Color color;
  final double size;
  final Duration duration;

  final bool isActive;

  const DockItem({
    super.key,
    required this.icon,
    this.iconPath,
    required this.label,
    required this.color,
    required this.size,
    required this.duration,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Tooltip(
            message: label,
            child: AnimatedContainer(
              duration: duration,
              curve: duration == Duration.zero ? Curves.linear : Curves.easeOut,
              width: size,
              height: size,
              child: LiquidGlass(
                intensity: 0.8,
                blurSigma: iconPath != null ? 5.0 : 30.0,
                tintColor: iconPath != null ? null : color,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(size * 0.45),
                ),
                shadows: iconPath != null 
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: color.withValues(alpha: 0.45),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.3),
                          blurRadius: 1,
                          spreadRadius: -1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                child: Center(
                  child: iconPath != null
                      ? Padding(
                          padding: EdgeInsets.all(size * 0.05), // Subtle padding for the image inside glass
                          child: Image.asset(
                            iconPath!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(icon, color: Colors.white, size: size * 0.5),
                          ),
                        )
                      : Icon(icon, color: Colors.white, size: size * 0.5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isActive ? 1.0 : 0.0,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 6,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

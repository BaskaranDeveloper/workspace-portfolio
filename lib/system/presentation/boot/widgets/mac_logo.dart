import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MacLogo extends StatelessWidget {
  final double size;
  final Color color;

  const MacLogo({
    super.key,
    this.size = 100,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Extra safety against clipping
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        child: Image.asset(
          'asset/apple-logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback if asset fails to load
            return Icon(Icons.apple, size: size, color: color);
          },
        ),
      ),
    );
  }
}


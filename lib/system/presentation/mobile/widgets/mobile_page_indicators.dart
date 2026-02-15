import 'package:flutter/material.dart';

class MobilePageIndicators extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const MobilePageIndicators({
    super.key,
    this.pageCount = 3, // Default dummy count
    this.currentPage = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        final bool isActive = index == currentPage;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class BootProgressBar extends StatelessWidget {
  final double progress;
  const BootProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: AppColors.terminalDim.withValues(alpha: 0.2),
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.terminalBlue),
        minHeight: 2,
      ),
    );
  }
}

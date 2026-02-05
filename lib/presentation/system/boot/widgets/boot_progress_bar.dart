import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';

class BootProgressBar extends StatelessWidget {
  final double progress;

  const BootProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress Bar
        SizedBox(
          height: 2,
          width: 200,
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.terminalBlue.withValues(alpha: 0.2),

            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.terminalBlue,
            ),
          ),
        ),
      ],
    );
  }
}

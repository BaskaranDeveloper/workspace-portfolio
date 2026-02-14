import 'package:flutter/material.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

class BackgroundRipple extends StatelessWidget {
  const BackgroundRipple({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            AppColors.terminalBlue.withValues(alpha: 0.01),
            Colors.transparent,
            AppColors.terminalBlue.withValues(alpha: 0.01),
            Colors.transparent,
            AppColors.terminalBlue.withValues(alpha: 0.01),
            Colors.transparent,
          ],
          stops: const [0.0, 0.3, 0.4, 0.6, 0.7, 1.0],
        ),
      ),
    );
  }
}

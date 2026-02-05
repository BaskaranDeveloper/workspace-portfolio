import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

class BackgroundRipple extends StatelessWidget {
  const BackgroundRipple({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0, // spread it out
          colors: [
            // Center glow (faint)
            AppColors.terminalBlue.withValues(alpha: 0.01),

            // First dark gap
            Colors.transparent,

            // Second ripple ring (soft glow)
            AppColors.terminalBlue.withValues(alpha: 0.01),

            // Second gap
            Colors.transparent,

            // Third ripple ring (very subtle)
            AppColors.terminalBlue.withValues(alpha: 0.01),

            // Outer fade
            Colors.transparent,
          ],
          // These stops define the "rings"
          stops: const [
            0.0, // center start
            0.3, // gap start (center glow ends)
            0.45, // first ring peak
            0.6, // gap start
            0.75, // second ring peak
            1.0, // end
          ],
        ),
      ),
    );
  }
}

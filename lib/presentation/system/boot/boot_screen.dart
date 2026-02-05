import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';
import 'package:workspace/presentation/system/boot/widgets/background_ripple.dart';
import 'package:workspace/presentation/system/boot/widgets/boot_progress_bar.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progress;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    // progress animation
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    // start animation
    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Ripple
          const BackgroundRipple(),

          // Center Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. Terminal Icon
                const Icon(
                  Icons.terminal,
                  size: 48,
                  color: AppColors.terminalBlue,
                ),

                const SizedBox(height: 32),

                // 2. "Starting system..." Text
                const Text(
                  'Starting system...',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontFamily: 'monospace', // Or your specific font
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Progress Bar & Text
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final percentage = (_progress.value * 100).toInt();
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BootProgressBar(progress: _progress.value),

                        const SizedBox(height: 8),

                        // 4. "INITIALIZING... XX%" Row
                        SizedBox(
                          width: 200, // Match progress bar width
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // Change text based on progress
                                percentage < 100
                                    ? 'INITIALIZING'
                                    : 'SYSTEM READY',
                                style: TextStyle(
                                  color: AppColors.terminalDim,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                '$percentage%',
                                style: TextStyle(
                                  color: AppColors.terminalDim,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Footer Info (Kernel version etc.)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  // Blinking Red Dot (Status Indicator) - Optional decoration
                  // Container(
                  //   width: 4, height: 4,
                  //   decoration: const BoxDecoration(
                  //     color: AppColors.stateError,
                  //     shape: BoxShape.circle
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  Text(
                    'PORTFOLIOS KERNEL V1.0.4-STABLE',
                    style: TextStyle(
                      color: AppColors.terminalDim.withValues(alpha: 0.5),
                      fontSize: 10,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Right System Checks
          Positioned(
            bottom: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusLine('MEM_CHECK', 'OK'),
                _buildStatusLine('SEC_BOOT', 'ENABLED'),
                _buildStatusLine('UI_ENGINE', 'READY'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusLine(String label, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: AppColors.terminalDim.withValues(alpha: 0.4),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: AppColors.terminalDim.withValues(alpha: 0.6),
              fontSize: 9,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

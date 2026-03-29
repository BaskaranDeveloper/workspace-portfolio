import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workspace/system/presentation/boot/widgets/boot_progress_bar.dart';
import 'package:workspace/system/presentation/boot/widgets/mac_logo.dart';
import 'package:workspace/system/presentation/utils/full_screen_manager.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progress;
  late Animation<double> _opacity;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Fade-in animation for the logo
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    // progress animation
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 1.0, curve: Curves.linear),
      ),
    );

    // Listen for animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Automatically enter full screen after boot
        FullScreenManager.enterFullScreen();

        // Navigate based on screen size
        final double screenWidth = MediaQuery.of(context).size.width;
        if (screenWidth > 800) {
          context.go('/desktop');
        } else {
          context.go('/mobile');
        }
      }
    });

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
      backgroundColor: Colors.black, // macOS pure black background
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _opacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // macOS Apple Logo
                  const MacLogo(size: 80, color: Colors.white),

                  const SizedBox(height: 60), // Spacing between logo and bar

                  // Minimal Progress Bar
                  BootProgressBar(progress: _progress.value),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

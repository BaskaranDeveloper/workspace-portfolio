import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:workspace/system/presentation/mobile/widgets/mobile_wallpaper.dart';
import 'package:workspace/system/presentation/mobile/widgets/ios_status_bar.dart';

class MobileShell extends StatelessWidget {
  final Widget child;

  const MobileShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Responsive Redirection
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/desktop');
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      extendBody: true, // Allow body behind bottom/top bars if any
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Wallpaper (Background)
          const MobileWallpaper(),

          // 2. Main Content (SafeArea handling inside child pages or custom padding)
          // We wrap in SafeArea only for top/bottom system UI, but user wants full immersion.
          // Using a custom SafeArea for content.
          Positioned.fill(
            child: SafeArea(
              top: false, // Let content go behind status bar (custom one used)
              bottom: false,
              child: child,
            ),
          ),

          // 3. Status Bar (Top)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 48, // Or use MediaQuery padding top
            child: IOSStatusBar(),
          ),
        ],
      ),
    );
  }
}

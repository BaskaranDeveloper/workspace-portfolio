import 'package:flutter/material.dart';
import 'package:workspace/app/theme/app_colors.dart';
import 'package:workspace/presentation/system/dock/dock_view.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Wallpaper / Background Layer
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundDark,
                    AppColors.backgroundSecondary,
                  ],
                ),
              ),
            ),
          ),

          // 2. Dock Layer (Floating at bottom)
          Positioned(left: 0, right: 0, bottom: 20, child: DockView()),
        ],
      ),
    );
  }
}

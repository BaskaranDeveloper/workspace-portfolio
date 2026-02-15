import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:workspace/shared_ui/theme/app_colors.dart';

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
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(child: child),
    );
  }
}

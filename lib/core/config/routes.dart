import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../system/presentation/boot/boot_screen.dart';
import '../../system/presentation/desktop/desktop_screen.dart';
import '../../system/presentation/mobile/mobile_shell.dart';
import '../../system/presentation/mobile/home_screen.dart';
import '../../system/presentation/mobile/mobile_app_wrapper.dart';

class AppRouter {
  static final config = GoRouter(
    initialLocation: '/boot',
    routes: [
      GoRoute(path: '/boot', builder: (context, state) => const BootScreen()),
      GoRoute(
        path: '/desktop',
        builder: (context, state) => const DesktopScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MobileShell(child: child),
        routes: [
          GoRoute(
            path: '/mobile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MobileHomeScreen()),
          ),
          GoRoute(
            path: '/mobile/apps/:appId',
            pageBuilder: (context, state) {
              final appId = state.pathParameters['appId']!;
              return CustomTransitionPage(
                key: state.pageKey,
                child: MobileAppWrapper(appId: appId),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      const begin = 0.95;
                      const end = 1.0;
                      const curve = Curves.easeOutExpo;

                      var scaleAnimation = Tween(
                        begin: begin,
                        end: end,
                      ).chain(CurveTween(curve: curve)).animate(animation);

                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: scaleAnimation,
                          child: child,
                        ),
                      );
                    },
                transitionDuration: const Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    ],
  );
}

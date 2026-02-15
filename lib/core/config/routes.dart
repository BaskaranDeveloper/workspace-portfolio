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
            builder: (context, state) => const MobileHomeScreen(),
          ),
          GoRoute(
            path: '/mobile/apps/:appId',
            builder: (context, state) {
              final appId = state.pathParameters['appId']!;
              return MobileAppWrapper(appId: appId);
            },
          ),
        ],
      ),
    ],
  );
}

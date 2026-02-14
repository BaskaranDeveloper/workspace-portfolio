import 'package:go_router/go_router.dart';
import '../../system/presentation/boot/boot_screen.dart';
import '../../system/presentation/desktop/desktop_screen.dart';

class AppRouter {
  static final config = GoRouter(
    initialLocation: '/boot',
    routes: [
      GoRoute(path: '/boot', builder: (context, state) => const BootScreen()),
      GoRoute(
        path: '/desktop',
        builder: (context, state) => const DesktopScreen(),
      ),
    ],
  );
}

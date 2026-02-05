import 'package:go_router/go_router.dart';
import '../../presentation/system/boot/boot_screen.dart';
import '../../presentation/system/desktop/desktop_screen.dart';

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

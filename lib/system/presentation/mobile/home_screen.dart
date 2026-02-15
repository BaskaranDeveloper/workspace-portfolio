import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workspace/system/domain/registry/registry_provider.dart';
import 'package:workspace/system/presentation/mobile/widgets/mobile_dock.dart';
import 'package:workspace/system/presentation/mobile/widgets/mobile_page_indicators.dart';

class MobileHomeScreen extends ConsumerWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRegistry = ref.watch(appRegistryProvider);
    final allApps = appRegistry.apps
        .where((app) => app.showInMobileHome)
        .toList();

    // Specific apps for Dock (mimicking iOS core apps)
    // Terminal (~Safari), Projects (~Files/Photos), Contact (~Mail), About (~Settings)
    final dockAppIds = ['terminal', 'projects', 'contact', 'about'];

    final dockApps = allApps
        .where((app) => dockAppIds.contains(app.id))
        .toList();
    // Sort to match iOS order preference if needed, or keep registry order

    final homeApps = allApps
        .where((app) => !dockAppIds.contains(app.id))
        .toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Home Screen Grid
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                60,
                24,
                120,
              ), // Top padding for status bar, bottom for dock
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                ),
                itemCount: homeApps.length,
                itemBuilder: (context, index) {
                  final app = homeApps[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/mobile/apps/${app.id}');
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // App Icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                app.themeColor.withValues(alpha: 0.8),
                                app.themeColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(app.icon, color: Colors.white, size: 32),
                        ),
                        const SizedBox(height: 8),
                        // App Label
                        Text(
                          app.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2, // Tighter spacing like iOS
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Search Pill (Above Dock)
          Positioned(
            left: 0,
            right: 0,
            bottom: 110, // Above dock area
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search, color: Colors.white70, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Dock
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MobileDock(dockApps: dockApps),
          ),
        ],
      ),
    );
  }
}

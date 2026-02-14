import '../domain/app_manifest.dart';
import '../domain/app_registry.dart';

/// In-memory implementation of the AppRegistry.
/// Apps are registered at runtime (boot).
class InMemoryRegistry implements AppRegistry {
  final Map<String, AppManifest> _apps = {};

  @override
  void register(AppManifest app) {
    if (_apps.containsKey(app.id)) {
      // In a real system, we might log a warning or throw an error.
      // For now, we'll overwrite to allow hot-reload updates.
      print('Warning: Overwriting existing app registration for ${app.id}');
    }
    _apps[app.id] = app;
  }

  @override
  AppManifest? getApp(String id) {
    return _apps[id];
  }

  @override
  List<AppManifest> getAllApps() {
    return _apps.values.toList();
  }
}

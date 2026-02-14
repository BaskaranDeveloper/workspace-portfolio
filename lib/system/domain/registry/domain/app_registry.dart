import 'app_manifest.dart';

/// Service responsible for managing installed applications.
abstract class AppRegistry {
  /// Registers a new application with the system.
  void register(AppManifest app);

  /// Retrieves a specific app by its ID.
  AppManifest? getApp(String id);

  /// Returns a list of all registered applications.
  List<AppManifest> getAllApps();
}

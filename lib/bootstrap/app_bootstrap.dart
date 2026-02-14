import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workspace/system/domain/registry/registry_provider.dart';

/// Bootstrapper to initialize the app and register core plugins.
class AppBootstrap {
  static Future<void> init(ProviderContainer container) async {
    final registry = container.read(appRegistryProvider);
    // ignore: avoid_print
    print('Registry initialized: $registry');
  }
}

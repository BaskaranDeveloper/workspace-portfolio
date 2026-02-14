import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workspace/system/domain/registry/domain/app_registry.dart';
import 'data/in_memory_registry.dart';

final appRegistryProvider = Provider<AppRegistry>((ref) {
  return InMemoryRegistry();
});

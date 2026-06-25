import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

final class SystemProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (kDebugMode) {
      print('''
{
  "provider": "${context.provider.name ?? context.provider.runtimeType}",
  "oldValue": "$previousValue",
  "newValue": "$newValue"
}
''');
    }
  }
}

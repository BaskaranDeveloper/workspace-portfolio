import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workspace/system/domain/registry/registry_provider.dart';

class MobileAppWrapper extends ConsumerWidget {
  final String appId;

  const MobileAppWrapper({super.key, required this.appId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(appRegistryProvider);
    final app = registry.getApp(appId);

    if (app == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text('App "$appId" not found')),
      );
    }

    // Wrap in a Scaffold if the app builder doesn't provide one,
    // or just return the builder's result.
    // The builder is expected to return a full page widget.
    return app.mobileBuilder(context);
  }
}

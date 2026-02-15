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

    // We add top padding to account for the custom IOSStatusBar (48px)
    // and bottom padding for the home indicator if needed, though apps usually handle bottom.
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(padding: MediaQuery.of(context).padding.copyWith(top: 48)),
      child: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: app.mobileBuilder(context),
      ),
    );
  }
}

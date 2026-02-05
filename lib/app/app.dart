import 'package:flutter/material.dart';
import 'package:workspace/app/config/app_router.dart';

class WorkspaceApp extends StatelessWidget {
  const WorkspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WORKSPACE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routerConfig: AppRouter.config,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:workspace/core/config/routes.dart';
import 'package:workspace/shared_ui/theme/app_theme.dart';

class WorkspaceApp extends StatelessWidget {
  const WorkspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PortfolioOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.config,
    );
  }
}

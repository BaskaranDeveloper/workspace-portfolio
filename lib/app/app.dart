import 'package:flutter/material.dart';
import 'package:workspace/presentation/system/boot/boot_screen.dart';

class WorkspaceApp  extends StatelessWidget {
  const WorkspaceApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WORKSPACE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const BootScreen(),
    );
  }
}
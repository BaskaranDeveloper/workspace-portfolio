import 'package:flutter/material.dart';
import 'package:workspace/features/terminal/presentation/terminal_view.dart';

class MobileTerminal extends StatelessWidget {
  const MobileTerminal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terminal'),
        backgroundColor: const Color(0xFF1E1E1E), // Match terminal background
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: const TerminalView(),
    );
  }
}

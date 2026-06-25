import 'package:flutter/material.dart';

class WindowFrame extends StatelessWidget {
  const WindowFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    );
  }
}

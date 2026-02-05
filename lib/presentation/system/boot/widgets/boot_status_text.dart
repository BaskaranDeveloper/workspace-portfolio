import 'package:flutter/material.dart';

class BootStatusText extends StatelessWidget {
  final String text;
  const BootStatusText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

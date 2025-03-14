import 'package:flutter/material.dart';

class NFloatingLabel extends StatelessWidget {
  const NFloatingLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).inputDecorationTheme.labelStyle,
    );
  }
}

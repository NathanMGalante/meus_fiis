import 'package:flutter/material.dart';

class NChildBuilder extends StatelessWidget {
  const NChildBuilder({super.key, required this.builder, required this.child});

  final Widget Function(BuildContext, Widget) builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}

import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_widgets/n_scroll_fade.dart';

class NChildScrollView extends StatelessWidget {
  NChildScrollView({
    super.key,
    required this.child,
    ScrollController? controller,
    this.scrollDirection = Axis.vertical,
  }) : controller = controller ?? ScrollController();

  final Widget child;
  final ScrollController controller;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return NScrollFade(
      controller: controller,
      scrollDirection: scrollDirection,
      child: child,
    );
  }
}

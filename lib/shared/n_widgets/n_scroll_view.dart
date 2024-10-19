import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_widgets/n_scroll_fade.dart';

class NScrollView extends StatelessWidget {
  NScrollView({
    super.key,
    this.scrollDirection = Axis.vertical,
    ScrollController? controller,
    required this.child,
  }) : scrollController = controller ?? ScrollController();

  final Axis scrollDirection;
  final Widget child;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return NScrollFade(
      controller: scrollController,
      scrollDirection: scrollDirection,
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: scrollDirection,
        child: child,
      ),
    );
  }
}

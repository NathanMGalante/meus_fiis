import 'package:flutter/material.dart';

class NConfig extends InheritedWidget {
  const NConfig({
    super.key,
    this.dropdownHintText,
    required super.child,
  });

  final String? dropdownHintText;

  static NConfig of(BuildContext context) {
    final NConfig? result =
        context.dependOnInheritedWidgetOfExactType<NConfig>();
    assert(result != null, 'No NConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(NConfig oldWidget) {
    return oldWidget != this;
  }
}

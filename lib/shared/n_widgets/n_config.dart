import 'package:flutter/material.dart';

class NConfig extends InheritedWidget {
  const NConfig({
    super.key,
    this.dropdownHintText,
    this.searchHintText,
    required super.child,
  });

  final String? dropdownHintText;
  final String? searchHintText;

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

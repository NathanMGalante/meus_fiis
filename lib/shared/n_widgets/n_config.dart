import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_date_formatter.dart';

class NConfig extends InheritedWidget {
  NConfig({
    super.key,
    this.dropdownHintText,
    this.searchHintText,
    this.locale,
    required super.child,
  }) {
    NDateFormatter.setLocale(locale);
  }

  final String? dropdownHintText;
  final String? searchHintText;
  final Locale? locale;

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

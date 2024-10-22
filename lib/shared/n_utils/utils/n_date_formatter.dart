import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NDateFormatter {
  static String? _locale;
  static NDateFormatter? _instance;

  factory NDateFormatter(Locale locale) {
    _instance ??= NDateFormatter._(null);
    return _instance!;
  }

  NDateFormatter._(String? locale);

  static void setLocale(Locale? locale) {
    _locale = locale.toString();
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat.yMd(_locale).add_jm().format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat.yMd(_locale).format(dateTime);
  }
}
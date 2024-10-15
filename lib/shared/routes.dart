enum Routes {
  home,
}

extension RoutesExtension on Routes {
  String get route => '/$name';
}
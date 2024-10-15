enum Routes {
  dashboard,
}

extension RoutesExtension on Routes {
  String get route => '/$name';
}
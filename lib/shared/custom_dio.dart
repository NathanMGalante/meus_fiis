import 'package:dio/dio.dart';

class CustomDio {
  CustomDio._();

  static final CustomDio _instance = CustomDio._();

  final Dio _public = Dio();

  static Dio get public => _instance._public;
}
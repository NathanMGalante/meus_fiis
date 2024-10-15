import 'package:shared_preferences/shared_preferences.dart';

enum StorageKeys {
  homeView,
  wallet,
}

class Storage {
  static late SharedPreferences instance;

  static Future<void> initialize() async {
    instance = await SharedPreferences.getInstance();
  }
}

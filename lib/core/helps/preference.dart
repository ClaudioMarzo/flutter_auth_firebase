import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences._();
  static AppPreferences instance = AppPreferences._();
  SharedPreferences? prefs;

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveString(String key, String value) async {
    await prefs!.setString(key, value);
  }

  String? getString(String key) {
    return prefs!.getString(key);
  }

  Future<bool> delete(String key) async {
    return await prefs!.remove(key);
  }

  Future deleteAll() => prefs!.clear();

  int? getInt(String key) {
    return prefs!.getInt(key);
  }

  bool? getBool(String key) {
    return prefs!.getBool(key);
  }
}

Future resetPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  await AppPreferences.instance.deleteAll();
  await prefs.remove('counter');
}

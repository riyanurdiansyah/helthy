import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._internal();
  static SharedPreferences? _prefs;

  SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Getters
  String? getString(String key) => _prefs?.getString(key);
  int? getInt(String key) => _prefs?.getInt(key);
  bool? getBool(String key) => _prefs?.getBool(key);
  double? getDouble(String key) => _prefs?.getDouble(key);
  List<String>? getStringList(String key) => _prefs?.getStringList(key);

  // Setters
  Future<bool> setString(String key, String value) async =>
      await _prefs!.setString(key, value);
  Future<bool> setInt(String key, int value) async =>
      await _prefs!.setInt(key, value);
  Future<bool> setBool(String key, bool value) async =>
      await _prefs!.setBool(key, value);
  Future<bool> setDouble(String key, double value) async =>
      await _prefs!.setDouble(key, value);
  Future<bool> setStringList(String key, List<String> value) async =>
      await _prefs!.setStringList(key, value);

  // Remove & Clear
  Future<bool> remove(String key) async => await _prefs!.remove(key);
  Future<bool> clear() async => await _prefs!.clear();
}

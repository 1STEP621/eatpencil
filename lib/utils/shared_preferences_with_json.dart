import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JsonStore {
  JsonStore();
  static Future<void> save(String key, Object value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static Future<T?> load<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key) ?? "null") as T?;
  }
}

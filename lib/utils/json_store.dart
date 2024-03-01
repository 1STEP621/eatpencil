import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

class SecureJsonStore {
  SecureJsonStore();

  static Future<void> save(String key, Object value) async {
    const storage = FlutterSecureStorage();
    storage.write(key: key, value: json.encode(value));
  }

  static Future<T?> load<T>(String key) async {
    const storage = FlutterSecureStorage();
    return json.decode(await storage.read(key: key) ?? "null") as T?;
  }
}

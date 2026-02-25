// import 'package:flutter/material.dart';

// class ThemeController extends ChangeNotifier {
//   ThemeMode _themeMode = ThemeMode.system;

//   ThemeMode get themeMode => _themeMode;

//   void setLightMode() {
//     _themeMode = ThemeMode.light;
//     notifyListeners();
//   }

//   void setDarkMode() {
//     _themeMode = ThemeMode.dark;
//     notifyListeners();
//   }

//   void setSystemMode() {
//     _themeMode = ThemeMode.system;
//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  static const String _key = 'theme_mode';

  // Call this once at app startup to load saved theme
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key) ?? 'system';

    if (saved == 'light') {
      _themeMode = ThemeMode.light;
    } else if (saved == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setLightMode() async {
    _themeMode = ThemeMode.light;
    notifyListeners();
    await _save('light');
  }

  Future<void> setDarkMode() async {
    _themeMode = ThemeMode.dark;
    notifyListeners();
    await _save('dark');
  }

  Future<void> setSystemMode() async {
    _themeMode = ThemeMode.system;
    notifyListeners();
    await _save('system');
  }

  Future<void> _save(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, value);
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/themes/app_theme.dart';

class ThemeRiverpod extends ChangeNotifier
{
  ThemeRiverpod({required this.prefs}) : _themeData = _loadTheme(prefs);

  late ThemeData _themeData;
  bool _isDarkMode = false;
  late final SharedPreferences prefs;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    _saveTheme(prefs, isDarkMode);
    notifyListeners();
  }

  static ThemeData _loadTheme(SharedPreferences prefs) {
    bool isDarkMode = prefs.getBool('isDark') ?? false;
    return isDarkMode ? AppTheme.lightThemeMode : AppTheme.darkThemeMode;
  }

  static Future<void> _saveTheme(
      SharedPreferences prefs,
      bool isDarkMode,
      ) async {
    await prefs.setBool('isDark', isDarkMode);
  }

  void toggleTheme() async {
    themeData = isDarkMode ? ThemeData.light() : ThemeData.dark();
    _isDarkMode = !_isDarkMode;
  }
}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }

  static const String _showingOnlyMyWorksKey = "showingOnlyMyWorks";
  bool _showingOnlyMyWorks = false;
  bool get showingOnlyMyWorks => _showingOnlyMyWorks;
  set showingOnlyMyWorks(bool value) {
    _showingOnlyMyWorks = value;
    saveSettingBool(key: _showingOnlyMyWorksKey, value: value);
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDarkMode');
    if (isDark != null) {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    }

    bool? isShowingOnlyMyWorksSave = prefs.getBool(_showingOnlyMyWorksKey);
    if (isShowingOnlyMyWorksSave != null) {
      showingOnlyMyWorks = isShowingOnlyMyWorksSave;
    }

    notifyListeners();
  }

  saveSettingBool({required String key, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  String? lastScreen;
}

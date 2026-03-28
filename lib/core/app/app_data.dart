import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData with ChangeNotifier {
  bool _isDarkMode = false;
  int _currentNavBarIndex = 0;
  static SharedPreferences? _prefs;

  bool get isDarkMode => _isDarkMode;
  int get currentNavBarIndex => _currentNavBarIndex;

  AppData() {
    getAppData();
  }

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> getAppData() async {
    final prefs = await _getPrefs();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  void toggleDarkMode() async {
    final prefs = await _getPrefs();
    await prefs.setBool('darkMode', !_isDarkMode);
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void changeNavBarIndex(int index) {
    _currentNavBarIndex = index;
    notifyListeners();
  }

  void resetAppData() {
    _currentNavBarIndex = 0;
    notifyListeners();
  }
}

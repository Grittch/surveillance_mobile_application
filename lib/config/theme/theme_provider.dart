import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeStateNotifier = ChangeNotifierProvider((ref) => ThemeState());

class ThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;

  ThemeState() {
    _loadDarkModePreference();
  }

  void setLightTheme() {
    isDarkModeEnabled = false;
    notifyListeners();
    _saveDarkModePreference(isDarkModeEnabled);
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    notifyListeners();
    _saveDarkModePreference(isDarkModeEnabled);
  }

  Future<void> _saveDarkModePreference(bool isDarkModeEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
  }

  Future<void> _loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    notifyListeners();
  }
}

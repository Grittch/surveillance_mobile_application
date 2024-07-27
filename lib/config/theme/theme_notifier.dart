import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<Color> {
  ThemeNotifier() : super(const Color.fromARGB(255, 123, 151, 172)) {
    _initializeColor();
  }

  Future<void> _initializeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('backgroundColor');

    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  void onColorChanged(Color color) async {
    state = color;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('backgroundColor', color.value);
  }

  Color myColor() {
    return state;
  }
}

final colorProvider = StateNotifierProvider<ThemeNotifier, Color>((ref) => ThemeNotifier());

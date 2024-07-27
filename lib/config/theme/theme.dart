import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_app_prot1/config/theme/theme_notifier.dart';

final primaryColorProvider = Provider<Color>((ref) {
  ThemeNotifier themeNotifier = ref.watch(colorProvider.notifier);
  return themeNotifier.myColor();
});

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color.fromARGB(255, 247, 250, 254),
    secondary: Color.fromARGB(255, 38, 38, 38),
  ),
  fontFamily: GoogleFonts.roboto().fontFamily,
  textTheme: const TextTheme().apply(),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
  ),
);

import 'package:flutter/material.dart';

class ThemeDataMutiStore {
  final Color colorSeed;
  final bool isDarkMode;

  ThemeDataMutiStore({required this.colorSeed, required this.isDarkMode});

  ThemeData getThemeData() {
    return ThemeData(
      splashColor: Colors.transparent,
      colorSchemeSeed: colorSeed,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      fontFamily: "Comfortaa-Regular",
    );
  }

  ThemeDataMutiStore copyWith({Color? colorSeed, bool? isDarkMode}) =>
      ThemeDataMutiStore(colorSeed: colorSeed ?? this.colorSeed, isDarkMode: isDarkMode ?? this.isDarkMode);
}

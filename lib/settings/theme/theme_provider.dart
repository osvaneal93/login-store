import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/settings/preferences/preferences_config.dart';
import 'package:multi_store_app/settings/theme/theme_setings.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeController, ThemeDataMutiStore>((ref) =>
    ThemeController(ThemeDataMutiStore(isDarkMode: Preferences.getThemeBrightness, colorSeed: Colors.yellowAccent)));

class ThemeController extends StateNotifier<ThemeDataMutiStore> {
  ThemeController(super.state);
  void toggleDarkMode() {
    Preferences.saveThemeBrightness(!state.isDarkMode);
    state = state.copyWith(isDarkMode: Preferences.getThemeBrightness);
  }
}

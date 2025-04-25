import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String THEME_KEY = 'theme_mode';
  final SharedPreferences sharedPreferences;

  ThemeCubit({required this.sharedPreferences})
    : super(ThemeState(themeMode: ThemeMode.system)) {
    _loadTheme();
  }

  void _loadTheme() {
    final savedThemeIndex = sharedPreferences.getInt(THEME_KEY);
    if (savedThemeIndex != null) {
      final themeMode = ThemeMode.values[savedThemeIndex];
      emit(ThemeState(themeMode: themeMode));
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    sharedPreferences.setInt(THEME_KEY, themeMode.index);
    emit(ThemeState(themeMode: themeMode));
  }

  void toggleTheme() {
    final currentTheme = state.themeMode;
    late ThemeMode newTheme;

    if (currentTheme == ThemeMode.system) {
      // If system, check system brightness and toggle to opposite
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      newTheme =
          brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    } else {
      // If already set to light or dark, toggle between them
      newTheme =
          currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    }

    setThemeMode(newTheme);
  }

  /// Check if the current active theme is dark
  bool get isDarkMode {
    if (state.themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return state.themeMode == ThemeMode.dark;
  }
}

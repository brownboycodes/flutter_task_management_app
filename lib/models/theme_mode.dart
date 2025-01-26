import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart' as material;

part 'theme_mode.g.dart';

@HiveType(typeId: 1) // Assign a unique type ID for Hive
enum ThemeMode {
  @HiveField(0)
  system,
  @HiveField(1)
  light,
  @HiveField(2)
  dark;

  static ThemeMode fromTheme(material.ThemeMode? themeMode) {
    switch (themeMode) {
      case material.ThemeMode.light:
        return ThemeMode.light;
      case material.ThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  material.ThemeMode toThemeMode() {
    switch (this) {
      case ThemeMode.light:
        return material.ThemeMode.light;
      case ThemeMode.dark:
        return material.ThemeMode.dark;
      default:
        return material.ThemeMode.light;
    }
  }
}

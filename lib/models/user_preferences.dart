import 'package:flutter/material.dart';
import 'package:task_management_app/task_management_app.dart';

///[UserPreferences] is a class that stores the user preferences such as theme mode and sort order
class UserPreferences {
  UserPreferences({
    this.themeMode = ThemeMode.system,
    this.sortOrder = SortOrder.defaultOrder,
  });
  ///[themeMode] is the theme mode of the app
  ThemeMode themeMode;

  ///[sortOrder] is the sort order of the tasks
  SortOrder sortOrder;


}


extension ThemeModeExtension on ThemeMode{
  ///[label] is the string representation of the theme mode
  String get label{
    switch(this){
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}

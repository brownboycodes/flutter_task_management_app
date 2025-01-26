import 'package:hive/hive.dart';
import 'package:task_management_app/models/theme_mode.dart';
import 'package:task_management_app/task_management_app.dart';

part 'user_preferences.g.dart';

///[UserPreferences] is a class that stores the user preferences such as theme mode and sort order
@HiveType(typeId: 0)
class UserPreferences {

  UserPreferences({
    this.themeMode = ThemeMode.system,
    this.sortOrder = SortOrder.defaultOrder,
  });
  ///[themeMode] is the theme mode of the app
  @HiveField(0)
  ThemeMode themeMode;

  ///[sortOrder] is the sort order of the tasks
  @HiveField(1)
  SortOrder sortOrder;

  UserPreferences copyWith({
    ThemeMode? themeMode,
    SortOrder? sortOrder,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  UserPreferences updateValue({
    ThemeMode? themeMode,
    SortOrder? sortOrder,
  }) {
    if(themeMode != null){
      this.themeMode = themeMode;
    }
    if(sortOrder != null){
      this.sortOrder = sortOrder;
    }
    return this;
  }

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

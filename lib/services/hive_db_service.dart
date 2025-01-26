import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management_app/task_management_app.dart';

import '../models/theme_mode.dart';

class HiveDBService {
  static final HiveDBService _singleton = HiveDBService._internal();

  factory HiveDBService() {
    return _singleton;
  }

  HiveDBService._internal();

  late Box _box;

  /// Initializes Hive and opens the database box
  Future<Box> initialize() async {
    final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(document.path);
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(SortOrderAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    _box = await Hive.openBox<UserPreferences>(DataBaseConstants.userPreferencesDB);
    // needed for debugging
    // for (var key in _box.keys) {
    //   try {
    //     print('Key: $key, Value: ${_box.get(key)}');
    //   } catch (e) {
    //     print('Error reading key $key: $e');
    //   }
    // }
    return _box;
  }

  /// Get user preferences
  UserPreferences getUserPreferences() {
    return _box.get(HiveDBConstants.userPreferences, defaultValue: UserPreferences())!;
  }

  /// Save user preferences
  Future<void> saveUserPreferences(UserPreferences preferences) async {
    await _box.put(HiveDBConstants.userPreferences, preferences);
  }

  /// Close Hive when shutting down the app
  Future<void> close() async {
    await _box.close();
  }
}

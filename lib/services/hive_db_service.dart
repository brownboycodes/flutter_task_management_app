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
    print("18 initializing hive");
    final document = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(document.path);
    print("20 hive.init is done");
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(SortOrderAdapter());
    Hive.registerAdapter(UserPreferencesAdapter());
    print("26 hive adapters are registered");
    _box = await Hive.openBox<UserPreferences>(DataBaseConstants.userPreferencesDB);
    print("hive box is $_box");
    for (var key in _box.keys) {
      try {
        print('Key: $key, Value: ${_box.get(key)}');
      } catch (e) {
        print('Error reading key $key: $e');
      }
    }
    return _box;
  }

  // /// Retrieves a value by key from the Hive box
  // dynamic get(String key, {dynamic defaultValue}) {
  //   try {
  //     _box;
  //   } catch (e) {
  //     print("hive box is not initialized");
  //     initialize();
  //     // print("box is $_box");
  //   }
  //   return _box.get(key, defaultValue: defaultValue);
  // }
  //
  // /// Sets a value in the Hive box
  // Future<void> set(String key, dynamic value) async {
  //   await _box.put(key, value);
  //   print("key is $key and value is $value");
  // }
  //
  // /// Closes the Hive box (to be called during app shutdown)
  // Future<void> close() async {
  //   await _box.close();
  // }

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
    print("box closed");
  }
}

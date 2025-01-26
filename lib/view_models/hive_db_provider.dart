import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';
import 'package:task_management_app/models/theme_mode.dart' as tm;

final hiveDBProvider = Provider<HiveDBService>((ref) {
  return HiveDBService();
});

class HiveStateNotifier extends StateNotifier<UserPreferences?> {
  final HiveDBService hiveDBService;

  HiveStateNotifier(this.hiveDBService) : super(null) {
    _loadInitialData();
  }

  /// Load initial data from Hive
  Future<void> _loadInitialData() async {
    state = hiveDBService.getUserPreferences();
    print("state is $state");
  }

  /// Update a value in the state and Hive
  Future<void> updateValue({
    ThemeMode? themeMode,
    SortOrder? sortOrder,
  }) async {
    state = state?.updateValue(themeMode: tm.ThemeMode.fromTheme(themeMode), sortOrder: sortOrder);
    if(state != null) {
      await hiveDBService.saveUserPreferences(state!);
      print("updated state is $state");
    }
  }
}

final hiveStateNotifierProvider =
StateNotifierProvider<HiveStateNotifier, UserPreferences?>((ref) {
  final hiveDB = ref.read(hiveDBProvider);
  return HiveStateNotifier(hiveDB);
});

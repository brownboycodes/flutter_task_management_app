import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

final hiveDBProvider = Provider<HiveDBService>((ref) {
  return HiveDBService();
});

class HiveStateNotifier extends StateNotifier<Map<String, dynamic>> {
  final HiveDBService hiveDBService;

  HiveStateNotifier(this.hiveDBService) : super({}) {
    _loadInitialData();
  }

  /// Load initial data from Hive
  Future<void> _loadInitialData() async {
    state = {
      'theme': hiveDBService.get('themeMode', defaultValue: 'system'),
      'sortOrder': hiveDBService.get('sortOrder', defaultValue: "Default"),
    };
  }

  /// Update a value in the state and Hive
  Future<void> updateValue(String key, dynamic value) async {
    state = {...state, key: value};
    await hiveDBService.set(key, value);
  }
}

final hiveStateNotifierProvider =
StateNotifierProvider<HiveStateNotifier, Map<String, dynamic>>((ref) {
  final hiveDB = ref.read(hiveDBProvider);
  return HiveStateNotifier(hiveDB);
});

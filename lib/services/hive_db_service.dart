
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_management_app/task_management_app.dart';

class HiveDBService {
  static final HiveDBService _singleton = HiveDBService._internal();

  factory HiveDBService() {
    return _singleton;
  }

  HiveDBService._internal();

  late Box _box;

  void initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    _box = await Hive.openBox(DataBaseConstants.userPreferencesDB);
  }

  /// Retrieves a value by key from the Hive box
  dynamic get(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  /// Sets a value in the Hive box
  Future<void> set(String key, dynamic value) async {
    await _box.put(key, value);
  }

  /// Closes the Hive box (to be called during app shutdown)
  Future<void> close() async {
    await _box.close();
  }
}
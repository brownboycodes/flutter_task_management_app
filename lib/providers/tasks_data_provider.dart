import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management_app/task_management_app.dart';

///[TasksDataProvider] contains the providers for the tasks data management via CRUD operations
class TasksDataProvider extends StateNotifier<Database?> {

  static final TasksDataProvider _singleton = TasksDataProvider._internal();

  factory TasksDataProvider(Ref ref) {
    _singleton.ref=ref;
    return _singleton;
  }

  TasksDataProvider._internal():super(null);

  late Ref ref;

  Future<void> initializeDatabase() async {
    if (state != null) return; // If the database is already initialized, return
    if(kDebugMode){
      debugPrint("Initializing the database...");
    }
    state = await ref.read(TasksDataProvider.tasksDBServiceProvider).getDataBase();
  }

  static final databaseProvider = StateNotifierProvider<TasksDataProvider, Database?>((ref) {
    return TasksDataProvider(ref);
  });

  ///[tasksDBServiceProvider] provides the [TasksDBService] instance
  static final tasksDBServiceProvider = Provider<TasksDBService>((ref) => TasksDBService());
  static final tasksDBProvider = FutureProvider.autoDispose<Database>((ref) async{
    final dbService = ref.watch(tasksDBServiceProvider);
    final data = await dbService.getDataBase();
    return data;
  });

  ///[fetchTasksProvider] provides a list of tasks from the database
  static final fetchTasksProvider = FutureProvider.autoDispose<List<Task>>((ref) async{
    // final db = await ref.watch(tasksDBProvider.future);
    final dbNotifier = ref.read(TasksDataProvider.databaseProvider.notifier);
    await dbNotifier.initializeDatabase();
    if (kDebugMode) {
      debugPrint("Database initialized");
    }
    final db = ref.watch(databaseProvider);
    final dbService = ref.watch(tasksDBServiceProvider);
    return db!=null? await dbService.fetchTasks(db):[];
  });

  ///[createTaskProvider] creates a task in the database
  static final createTaskProvider = FutureProvider.autoDispose.family<int,Task>((ref,task) async{
    final db = ref.watch(databaseProvider);
    final dbService = ref.watch(tasksDBServiceProvider);
    return db!=null? dbService.createTask(db,task):Future.value(0);
  });

  ///[updateTaskProvider] updates a task in the database
  static final updateTaskProvider = FutureProvider.autoDispose.family<int,Task>((ref,task) async{
    final db = ref.watch(databaseProvider);
    final dbService = ref.watch(tasksDBServiceProvider);
    return db!=null? await dbService.updateTask(db,task):Future.value(0);
  });

  ///[deleteTaskProvider] deletes a task from the database
  static final deleteTaskProvider = FutureProvider.autoDispose.family<int,Task>((ref,task) async{
    final db = ref.watch(databaseProvider);
    final dbService = ref.watch(tasksDBServiceProvider);
    return db!=null? await dbService.deleteTask(db,task):Future.value(0);
  });

  static final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
        (ref) => TaskListNotifier(),
  );

  static final activeTaskStateProvider = StateNotifierProvider<TaskNotifier,Task?>((ref) {
    return TaskNotifier();
  });
}

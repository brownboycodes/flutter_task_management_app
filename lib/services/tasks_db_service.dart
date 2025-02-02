import 'package:sqflite/sqflite.dart';
import 'package:task_management_app/task_management_app.dart';
import 'package:path/path.dart';

class TasksDBService{
  static final TasksDBService _singleton = TasksDBService._internal();

  factory TasksDBService() {
    return _singleton;
  }

  TasksDBService._internal();

  ///[getDataBase] returns the database instance, and creates the database if it does not exist
  Future<Database> getDataBase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DataBaseConstants.tasksDB),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT, dueDate TEXT, priority TEXT, status TEXT)',
        );
      },
    );
  }

  ///[fetchTasks] returns a list of tasks from the database
  Future<List<Task>> fetchTasks(Database database) async {
    final tasks = await database.query(DataBaseConstants.tasksTable);
    return tasks.map((task) => Task.fromJson(task)).toList();
  }

  ///[createTask] creates a task in the database
  Future<int> createTask(Database database, Task task) async {
    final id = await database.insert(DataBaseConstants.tasksTable, task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  ///[updateTask] updates a task in the database
  Future<int> updateTask(Database database, Task task) async {
    final id = await database.update(DataBaseConstants.tasksTable, task.toJson(),
        where: 'id = ?', whereArgs: [task.id]);
    return id;
  }

  ///[deleteTask] deletes a task from the database
  Future<int> deleteTask(Database database, Task task) async {
    final id = await database.delete(DataBaseConstants.tasksTable,
        where: 'id = ?', whereArgs: [task.id]);
    return id;
  }
}

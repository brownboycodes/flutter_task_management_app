import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void initializeTasks(List<Task> tasks) {
    state = tasks;
  }

  void addTask(Task task) {
    state = [...state, task];
  }

  List<Task> getTasks() {
    return state;
  }

  void updateTask(Task updatedTask) {
    state = state.map((task) {
      if (task.id == updatedTask.id) {
        return updatedTask;
      }
      return task;
    }).toList();
  }

  void deleteTask(Task deletedTask) {
    state = state.where((task) => task.id != deletedTask.id).toList();
  }
}

class TaskNotifier extends StateNotifier<Task?>{
  TaskNotifier():super(null);

  void setTask(Task? task){
    state = task;
  }
}
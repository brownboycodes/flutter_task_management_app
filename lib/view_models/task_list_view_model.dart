//singleton class
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskListViewModel {
  static final TaskListViewModel _singleton = TaskListViewModel._internal();

  factory TaskListViewModel(WidgetRef ref) {
    _singleton.ref = ref;
    _singleton.fetchStoredTasks();
    return _singleton;
  }

  TaskListViewModel._internal();

  late WidgetRef ref;

  List<Task> realTimeTasks() {
    return ref.watch(TasksDataProvider.taskListProvider);
  }

  List<Task> getFilteredTasks() {
    final tasksLive = realTimeTasks();
    final searchState = ref.watch(filterStateProvider);
    final searchKeyword = ref.watch(searchKeywordProvider);
    List<Task> tasks = tasksLive;
    if (searchKeyword.isNotEmpty) {
      tasks = tasks
          .where((element) =>
          element.title!.toLowerCase().contains(searchKeyword.toLowerCase()))
          .toList();
      print("$searchKeyword searched tasks are $tasks");
    }
    if (searchState == SortOrder.dueDates) {
      final time = DateTime.now();
      tasks.sort((a, b) => (a.dueDate ?? time).compareTo(b.dueDate ?? time));
    } else if (searchState == SortOrder.priority) {
      tasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    }
    return tasks;
  }

  bool noTasks() {
    return realTimeTasks().isEmpty;
  }

  fetchStoredTasks() async {
    final tasks = await ref.read(TasksDataProvider.fetchTasksProvider.future);
    print("fetched tasks are $tasks");
    if (tasks.isNotEmpty) {
      ref
          .read(TasksDataProvider.taskListProvider.notifier)
          .initializeTasks(tasks);
    }
  }
}
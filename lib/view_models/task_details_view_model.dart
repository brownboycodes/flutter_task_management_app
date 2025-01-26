import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskDetailsViewModel{
  static final TaskDetailsViewModel _singleton = TaskDetailsViewModel._internal();

  factory TaskDetailsViewModel(WidgetRef ref, Task? task) {
    _singleton.ref = ref;
    _singleton.task = task;
    _singleton.initializeTaskDetails();
    return _singleton;
  }

  TaskDetailsViewModel._internal();

  late WidgetRef ref;
  late Task? task;

  late ValueNotifier<DateTime> dueDateNotifier;
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  late ValueNotifier<Priority> priorityNotifier;
  late ValueNotifier<TaskStatus> taskStatusNotifier;

  void initializeTaskDetails() {
    dueDateNotifier = ValueNotifier<DateTime>(task?.dueDate ?? DateTime.now());
    titleTextController = TextEditingController(text: task?.title);
    descriptionTextController = TextEditingController(text: task?.description);
    priorityNotifier = ValueNotifier<Priority>(task?.priority  ?? Priority.none);
    taskStatusNotifier = ValueNotifier<TaskStatus>(task?.status ?? TaskStatus.pending);
  }

  void updateData(Task? task) {
    if(task==null) {
      dueDateNotifier = ValueNotifier(DateTime.now());
      titleTextController = TextEditingController();
      descriptionTextController =
          TextEditingController();
      priorityNotifier = ValueNotifier(Priority.none);
      taskStatusNotifier =
          ValueNotifier(TaskStatus.pending);
    }else if (task != this.task) {
      this.task = task;
      initializeTaskDetails();
    }
  }

  void addTask(BuildContext context,bool isLandScape) async{
    final time = DateTime.now();
    final task = Task(
      id: time.millisecondsSinceEpoch,
      createdAt: time,
      title: titleTextController.text,
      description: descriptionTextController.text,
      dueDate:dueDateNotifier.value,
      priority: priorityNotifier.value,
      status: TaskStatus.pending,
    );
    final tasks =
    await ref.read(TasksDataProvider.createTaskProvider(task).future);
    if(context.mounted){
      ref.read(TasksDataProvider.taskListProvider.notifier).addTask(task);
      if(isLandScape) {
        ref.read(
            TasksDataProvider.activeTaskStateProvider.notifier)
            .setTask(null);
      }else{
        Navigator.pop(context);
      }
    }
  }

  void deleteTask(BuildContext context,bool isLandScape) async{
      await ref
          .read(TasksDataProvider.deleteTaskProvider(task!).future);
      if(context.mounted){
        ref.read(TasksDataProvider.taskListProvider.notifier).deleteTask(task!);
        if(isLandScape) {
          ref.read(
              TasksDataProvider.activeTaskStateProvider.notifier)
              .setTask(null);
        }else {
          Navigator.pop(context);
        }
      }
    }

    void updateTask(BuildContext context,bool isLandScape) async{
        final task =this.task!.copyWith(
          title: titleTextController.text,
          description: descriptionTextController.text,
          dueDate:dueDateNotifier.value,
          priority: priorityNotifier.value,
          status: taskStatusNotifier.value,
        );
        final tasks = await ref
            .read(TasksDataProvider.updateTaskProvider(task).future);

        if(context.mounted){
          ref.read(TasksDataProvider.taskListProvider.notifier).updateTask(task);
          if(isLandScape) {
            ref.read(
                TasksDataProvider.activeTaskStateProvider.notifier)
                .setTask(null);
          }else {
            Navigator.pop(context);
          }
        }
    }

}
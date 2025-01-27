import 'package:flutter/material.dart';
import 'package:task_management_app/task_management_app.dart';

///[TaskStatus] is an enum class that represents the status of a task
enum TaskStatus {
  pending(TaskStatusConstants.pending, Colors.red),
  completed(TaskStatusConstants.completed, Colors.green);

  ///[label] is the label of the status
  final String label;

  ///[color] is the color of the priority
  final Color color;

  const TaskStatus(this.label,this.color);

  static TaskStatus fromString(String? label) {
    switch (label) {
      case TaskStatusConstants.completed:
        return TaskStatus.completed;
      default:
        return TaskStatus.pending;
    }
  }
}


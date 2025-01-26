import 'package:flutter/material.dart';

///[Priority] is an enum class that represents the priority of a task
enum Priority {
  p0("P0", Colors.red),
  p1("P1", Colors.deepOrange),
  p2("P2", Colors.amber),
  p3("P3", Colors.lightBlue),
  none("", Colors.transparent);

  ///[label] is the label of the priority
  final String label;

  ///[color] is the color of the priority
  final Color color;

  const Priority(this.label, this.color);

  static Priority fromString(String? label) {
    switch (label) {
      case "P0":
        return Priority.p0;
      case "P1":
        return Priority.p1;
      case "P2":
        return Priority.p2;
      case "P3":
        return Priority.p3;
      default:
        return Priority.none;
    }
  }
}

///[TaskStatus] is an enum class that represents the status of a task
enum TaskStatus {
  pending("Pending", Colors.red),
  completed("Completed", Colors.green);

  ///[label] is the label of the status
  final String label;

  ///[color] is the color of the priority
  final Color color;

  const TaskStatus(this.label,this.color);

  static TaskStatus fromString(String? label) {
    switch (label) {
      case "Completed":
        return TaskStatus.completed;
      default:
        return TaskStatus.pending;
    }
  }
}


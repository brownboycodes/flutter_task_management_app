import 'package:flutter/material.dart';
import 'package:task_management_app/constants/priority_constants.dart';

///[Priority] is an enum class that represents the priority of a task
enum Priority {
  p0(PriorityConstants.p0, Colors.red),
  p1(PriorityConstants.p1, Colors.deepOrange),
  p2(PriorityConstants.p2, Colors.amber),
  p3(PriorityConstants.p3, Colors.lightBlue),
  none(PriorityConstants.pNone, Colors.transparent);

  ///[label] is the label of the priority
  final String label;

  ///[color] is the color of the priority
  final Color color;

  const Priority(this.label, this.color);

  static Priority fromString(String? label) {
    switch (label) {
      case PriorityConstants.p0:
        return Priority.p0;
      case PriorityConstants.p1:
        return Priority.p1;
      case PriorityConstants.p2:
        return Priority.p2;
      case PriorityConstants.p3:
        return Priority.p3;
      default:
        return Priority.none;
    }
  }
}


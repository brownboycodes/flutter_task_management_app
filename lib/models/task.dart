import 'package:task_management_app/task_management_app.dart';

class Task {
  Task(
      {required this.id,
        this.title,
      this.description,
      required this.createdAt,
      this.priority = Priority.none,
      this.dueDate,
      this.status = TaskStatus.pending
      });

  ///[createdAt] is the date and time when the task was created
  DateTime createdAt;

  ///[title] is the title of the task
  String? title;

  ///[description] is the description of the task
  String? description;

  ///[id] is the unique identifier of the task, at the time of creation
  ///it is set to the current time in milliseconds
  int id;

  ///[dueDate] is the date and time when the task is due
  DateTime? dueDate;

  ///[priority] is the priority of the task
  Priority priority;

  ///[status] is the status of the task
  TaskStatus status;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json[TaskModelConstants.id],
      title: json[TaskModelConstants.title],
      description: json[TaskModelConstants.description],
      createdAt: DateTime.parse(json[TaskModelConstants.createdAt]),
      dueDate:
          json[TaskModelConstants.dueDate] != null ? DateTime.parse(json[TaskModelConstants.dueDate]) : null,
      priority: Priority.fromString(json[TaskModelConstants.priority]),
      status: TaskStatus.fromString(json[TaskModelConstants.status]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TaskModelConstants.id: id,
      TaskModelConstants.title: title,
      TaskModelConstants.description: description,
      TaskModelConstants.createdAt: createdAt.toIso8601String(),
      TaskModelConstants.dueDate: dueDate?.toIso8601String(),
      TaskModelConstants.priority: priority.label,
      TaskModelConstants.status: status.label,
    };
  }

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    Priority? priority,
    TaskStatus? status,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Task &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.dueDate == dueDate &&
        other.priority == priority &&
        other.status == status;
  }
}


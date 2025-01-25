import 'package:flutter/material.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskStatusSwitch extends StatefulWidget {
  const TaskStatusSwitch({super.key, required this.taskStatusNotifier});

  final ValueNotifier<TaskStatus> taskStatusNotifier;

  @override
  State<TaskStatusSwitch> createState() => _TaskStatusSwitchState();
}

class _TaskStatusSwitchState extends State<TaskStatusSwitch> {
  late bool _taskStatus = widget.taskStatusNotifier.value==TaskStatus.completed;

  static const WidgetStateProperty<Icon> thumbIcon =
      WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close,color: Colors.grey,),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Switch(
          thumbIcon: thumbIcon,
          value: _taskStatus,
          activeTrackColor: Colors.greenAccent,
          inactiveTrackColor: Colors.redAccent,

          thumbColor: WidgetStateProperty. resolveWith<Color>((Set<WidgetState> states) {
            return Colors.white;
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            return Theme.of(context).colorScheme.onInverseSurface;
          }),
          onChanged: (bool value) {
            setState(() {
              _taskStatus = value;
            });
            widget.taskStatusNotifier.value = _taskStatus ? TaskStatus.completed : TaskStatus.pending;
          },
        ),
        Text(
          _taskStatus ? 'Completed' : 'Pending',
          style: TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.inverseSurface),
        ),
      ],
    );
  }
}

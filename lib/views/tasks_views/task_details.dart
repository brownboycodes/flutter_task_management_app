import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskDetails extends ConsumerStatefulWidget {
  TaskDetails({super.key, this.task});

  final Task? task;

  @override
  ConsumerState<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends ConsumerState<TaskDetails> {
  final hintStyle = TextStyle(color: Colors.grey);
  late TaskDetailsViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = TaskDetailsViewModel(ref, widget.task);
  }

  @override
  void didUpdateWidget(TaskDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    _viewModel.updateData(widget.task);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(fontSize: 9, color: Theme.of(context).colorScheme.inverseSurface);
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TITLE OF THE TASK
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  style: Theme.of(context).textTheme.displaySmall,
                  maxLines: 2,
                  controller: _viewModel.titleTextController,
                  onTapOutside: (event) {
                    if (FocusManager.instance.primaryFocus != null) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    }
                  },
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      hintText: 'My task is...',
                      hintStyle: hintStyle),
                ),
              ),
              TaskStatusSwitch(taskStatusNotifier: _viewModel.taskStatusNotifier,)
            ],
          ),
          //DESCRIPTION AND OTHER DETAILS OF THE TASK
          TextField(
            controller: _viewModel.descriptionTextController,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 5,
            onTapOutside: (event) {
              if (FocusManager.instance.primaryFocus != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            decoration: InputDecoration(
                disabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade50),
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'Add some description...',
                alignLabelWithHint: true,
                hintStyle: hintStyle),
          ),
          SizedBox(height: 16),
          //DUE DATE OF THE TASK
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.calendar_month),
                Text(
                  'Due Date',
                  style: labelStyle,
                )
              ]),
              DueDatePicker(initialDateNotifier: _viewModel.dueDateNotifier,),
            ],
          ),
          SizedBox(height: 16),
          //PRIORITY OF THE TASK
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.flag),
                Text(
                  "Priority",
                  style: labelStyle,
                )
              ]),
              PriorityPicker(priorityNotifier: _viewModel.priorityNotifier,)
            ],
          ),
          SizedBox(
            height: 18,
          ),
          widget.task == null
              ? TextButton(
                  onPressed: ()=>_viewModel.addTask(context, isLandScape),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(161),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Add Task',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _viewModel.deleteTask(context, isLandScape),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .error,
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'Delete Task',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _viewModel.updateTask(context, isLandScape),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(161),
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(
                          'Update Task',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}

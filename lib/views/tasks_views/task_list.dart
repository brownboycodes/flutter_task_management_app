import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList({super.key, required this.onTap});

  /// Callback when a task is tapped
  final Function(Task) onTap;

  @override
  ConsumerState<TaskList> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  @override
  void initState() {
    super.initState();
    viewModel = TaskListViewModel(ref);
  }
  late TaskListViewModel viewModel;


  @override
  Widget build(BuildContext context) {

    if (viewModel.noTasks()) {
      return Center(
        child: Image.asset(
          "assets/empty-box.png",
          width: 180,
          height: 180,
        ),
      );
    }

    final tasks = viewModel.getFilteredTasks();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(task.title ?? '',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              subtitle: Wrap(
                // alignment: WrapAlignment.spaceAround,
                spacing: 25,
                children: [
                  Text(
                      'Due Date: ${DateFormat.yMd('en_US').format(task.dueDate ?? DateTime.now())}'),
                  if (task.priority != Priority.none)
                    RichText(
                        text: TextSpan(
                            text: 'Priority: ',
                            children: [
                              TextSpan(
                                text: task.priority.label,
                                style: TextStyle(
                                  color: task.priority.color,
                                ),
                              )
                            ],
                            style: Theme.of(context).textTheme.bodySmall)),
                  RichText(
                      text: TextSpan(
                          text: "Status: ",
                          children: [
                            TextSpan(
                              text: task.status.label,
                              style: TextStyle(
                                color: task.status.color,
                              ),
                            )
                          ],
                          style: Theme.of(context).textTheme.bodySmall)),
                ],
              ),
              subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  )),
              onTap: () {
                // Unfocus the TextField
                if (FocusManager.instance.primaryFocus != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
                widget.onTap(task);
              },
            ),
          );
        },
      ),
    );
  }
}

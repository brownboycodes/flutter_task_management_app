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

  late ValueNotifier<DateTime> _dueDateNotifier;
  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextController;
  late ValueNotifier<Priority> _priorityNotifier;
  late ValueNotifier<TaskStatus> _taskStatusNotifier;
  // late List<Task> _taskList;

  @override
  void initState() {
    _dueDateNotifier = ValueNotifier(widget.task?.dueDate ?? DateTime.now());
    _titleTextController = TextEditingController(text: widget.task?.title);
    _descriptionTextController =
        TextEditingController(text: widget.task?.description);
    _priorityNotifier = ValueNotifier(widget.task?.priority ?? Priority.none);
    _taskStatusNotifier =
        ValueNotifier(widget.task?.status ?? TaskStatus.pending);
    // _taskList= ref.read(TasksDataProvider.taskListStateProvider.notifier).state;
    super.initState();
  }

  @override
  void didUpdateWidget(TaskDetails oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the counter property has changed
    if(widget.task==null) {
      _dueDateNotifier = ValueNotifier(DateTime.now());
      _titleTextController = TextEditingController();
      _descriptionTextController =
          TextEditingController();
      _priorityNotifier = ValueNotifier(Priority.none);
      _taskStatusNotifier =
          ValueNotifier(TaskStatus.pending);
    }else if (widget.task != oldWidget.task) {
      _dueDateNotifier = ValueNotifier(widget.task?.dueDate ?? DateTime.now());
      _titleTextController = TextEditingController(text: widget.task?.title);
      _descriptionTextController =
          TextEditingController(text: widget.task?.description);
      _priorityNotifier = ValueNotifier(widget.task?.priority ?? Priority.none);
      _taskStatusNotifier =
          ValueNotifier(widget.task?.status ?? TaskStatus.pending);
      setState(() {
      });
    }
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
                  controller: _titleTextController,
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
              TaskStatusSwitch(taskStatusNotifier: _taskStatusNotifier,)
            ],
          ),
          //DESCRIPTION AND OTHER DETAILS OF THE TASK
          TextField(
            controller: _descriptionTextController,
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
              DueDatePicker(initialDateNotifier: _dueDateNotifier,),
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
              PriorityPicker(priorityNotifier: _priorityNotifier,)
            ],
          ),
          SizedBox(
            height: 18,
          ),
          widget.task == null
              ? TextButton(
                  onPressed: () async{
                    final time = DateTime.now();
                    final task = Task(
                      id: time.millisecondsSinceEpoch,
                      createdAt: time,
                      title: _titleTextController.text,
                      description: _descriptionTextController.text,
                      dueDate:_dueDateNotifier.value,
                      priority: _priorityNotifier.value,
                      status: TaskStatus.pending,
                    );
                    final tasks =
                        await ref.read(TasksDataProvider.createTaskProvider(task).future);
                    if(mounted){
                      print("task created $tasks");
                      ref.read(TasksDataProvider.taskListProvider.notifier).addTask(task);
                      if(isLandScape) {
                        ref.read(
                            TasksDataProvider.activeTaskStateProvider.notifier)
                            .setTask(null);
                      }else{
                        Navigator.pop(context);
                      }
                    }
                  },
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
                        onPressed: () async{
                          final tasks = await ref
                              .read(TasksDataProvider.deleteTaskProvider(widget.task!).future);
                          if(mounted){
                            ref.read(TasksDataProvider.taskListProvider.notifier).deleteTask(widget.task!);
                            if(isLandScape) {
                              ref.read(
                                  TasksDataProvider.activeTaskStateProvider.notifier)
                                  .setTask(null);
                            }else {
                              Navigator.pop(context);
                            }
                          }
                        },
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
                        onPressed: () {
                          final task =(widget.task!).copyWith(
                            title: _titleTextController.text,
                            description: _descriptionTextController.text,
                            dueDate:_dueDateNotifier.value,
                            priority: _priorityNotifier.value,
                            status: _taskStatusNotifier.value,
                          );
                          final tasks = ref
                              .read(TasksDataProvider.updateTaskProvider(task).future);

                          if(mounted){
                            print("task updated $tasks");
                              ref.read(TasksDataProvider.taskListProvider.notifier).updateTask(task);
                            if(isLandScape) {
                              ref.read(
                                  TasksDataProvider.activeTaskStateProvider.notifier)
                                  .setTask(null);
                            }else {
                              Navigator.pop(context);
                            }
                          }
                        },
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

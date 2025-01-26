import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';
import 'package:task_management_app/views/search_views/tasks_search_bar.dart';

class TasksDashboard extends ConsumerStatefulWidget {
  TasksDashboard({super.key, required this.themeNotifier});

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  ConsumerState<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends ConsumerState<TasksDashboard> {

  Color get backgroundColor => _backgroundColor;
  Color _backgroundColor = Colors.red;

  set backgroundColor(Color value) {
    if (_backgroundColor != value) {
      setState(() {
        _backgroundColor = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hiveNotifier = ref.read(hiveStateNotifierProvider.notifier);
    final backgroundColor = _isDarkMode? Theme.of(context).colorScheme.onSurface
        : Theme.of(context).colorScheme.surface;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandScape =
              MediaQuery.of(context).orientation == Orientation.landscape;

          final listView = Scaffold(
            backgroundColor: _isDarkMode
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text("Task Management App"),
              actions: [
                IconButton(
                  icon: Icon(_isDarkMode ? Icons.sunny : Icons.nightlight),
                  onPressed: () {
                    widget.themeNotifier.value =
                        widget.themeNotifier.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                    hiveNotifier.updateValue(themeMode: widget.themeNotifier.value);

                  },
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TasksSearchBar(),
                Expanded(
                  child: TaskList(
                    onTap: (task) {
                     if(isLandScape){
                       ref.read(TasksDataProvider.activeTaskStateProvider.notifier).setTask(task);
                     } else{
                       showModalBottomSheet<void>(
                         context: context,
                         backgroundColor: backgroundColor,
                         constraints: BoxConstraints(
                           maxHeight: MediaQuery.of(context).size.height * 0.84,
                         ),
                         builder: (BuildContext context) {
                           return TaskDetails(task: task);
                         },
                       );
                     }
                    },
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation: isLandScape
                ? FloatingActionButtonLocation.startFloat
                : FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent.shade100,
              onPressed: isLandScape?  (){
                ref.read(TasksDataProvider.activeTaskStateProvider.notifier).setTask(null);
              }: () {
                FocusScope.of(context).unfocus();
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: backgroundColor,
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.84,
                  ),
                  builder: (BuildContext context) {
                    return TaskDetails();
                  },
                );
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.create),
            ),
          );
          if (isLandScape) {
            return Material(
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: listView,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final _selectedTask = ref.watch(TasksDataProvider.activeTaskStateProvider);
                      return Flexible(
                        flex: 3,
                        child: SingleChildScrollView(child: TaskDetails(task: _selectedTask,)),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return listView;
          }
        },
      ),
    );
  }

  bool get _isDarkMode => widget.themeNotifier.value == ThemeMode.dark;
}

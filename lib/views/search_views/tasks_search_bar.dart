import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class TasksSearchBar extends ConsumerWidget{
  const TasksSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Padding(
          padding:  const EdgeInsets.only(left: 8.0),
          child: FilterMenu(),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Search Tasks',
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.18))),
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
              onChanged: (value) {
                ref.read(searchKeywordProvider.notifier).updateSearchState(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
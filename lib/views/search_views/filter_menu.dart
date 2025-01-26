import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

class FilterMenu extends ConsumerStatefulWidget {
  const FilterMenu({super.key});

  @override
  ConsumerState<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends ConsumerState<FilterMenu> {

  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');


  @override
  void dispose() {
    _buttonFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final hiveState = ref.read(hiveStateNotifierProvider);
      final sortOrder = hiveState?.sortOrder;
      if (sortOrder != null) {
        _activate(SortOrder.values.firstWhere((element) => element == sortOrder));
      }
    });
    super.initState();
  }


  void _activate(SortOrder selection) {

    switch (selection) {
      case SortOrder.dueDates:
      case SortOrder.priority:
      default:
        ref.read(filterStateProvider.notifier).updateSearchState(selection);
        ref.read(hiveStateNotifierProvider.notifier).updateValue(sortOrder: selection);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: SortOrder.values.map((sortOrder) {
        return MenuItemButton(
          child: Text(sortOrder.label),
          onPressed: () => _activate(sortOrder),
        );
      },).toList(),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return IconButton(focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          }, icon: Icon(Icons.filter_alt),
          padding: EdgeInsets.all(15),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.18)),
          ),
        );
      },
    );
  }
}
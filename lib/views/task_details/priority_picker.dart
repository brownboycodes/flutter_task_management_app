import 'package:flutter/material.dart';
import 'package:task_management_app/task_management_app.dart';

class PriorityPicker extends StatefulWidget {
  const PriorityPicker({super.key,required this.priorityNotifier});

  final ValueNotifier<Priority> priorityNotifier;

  @override
  State<PriorityPicker> createState() => _PriorityPickerState();
}

class _PriorityPickerState extends State<PriorityPicker> {
  late Priority selectedPriority = widget.priorityNotifier.value;

  @override
  Widget build(BuildContext context) {

    final textStyle = TextStyle(
      color: Theme.of(context).colorScheme.inverseSurface
    );
    return SegmentedButton<Priority>(
      style: SegmentedButton.styleFrom(
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: selectedPriority.color,

      ),
      showSelectedIcon: false,
      emptySelectionAllowed: true,
      // selectedIcon: Icon(Icons.flag,color: Colors.white,),
      segments:  <ButtonSegment<Priority>>[
        ButtonSegment<Priority>(
            value: Priority.p0,
            label: Text(Priority.p0.label,style:textStyle),
            icon: Icon(Icons.flag,color: getPriorityFlagColor(Priority.p0),)),
        ButtonSegment<Priority>(
            value: Priority.p1,
            label: Text(Priority.p1.label,style:textStyle),
            icon: Icon(Icons.flag,color: getPriorityFlagColor(Priority.p1))),
        ButtonSegment<Priority>(
            value: Priority.p2,
            label: Text(Priority.p2.label,style:textStyle),
            icon: Icon(Icons.flag,color: getPriorityFlagColor(Priority.p2),)),
        ButtonSegment<Priority>(
            value: Priority.p3,
            label: Text(Priority.p3.label,style:textStyle),
            icon: Icon(Icons.flag,color: getPriorityFlagColor(Priority.p3),)),
      ],
      selected: <Priority>{selectedPriority},
      onSelectionChanged: (Set<Priority> newSelection) {
        if(newSelection.isEmpty){
          setState(() {
            selectedPriority = Priority.none;
          });
        } else{
          setState(() {
            selectedPriority = newSelection.first;
          });
        }
        widget.priorityNotifier.value = selectedPriority;
      },
    );
  }
  
  Color getPriorityFlagColor(Priority priority){
    return priority==selectedPriority?Colors.white:priority.color;
  }
}

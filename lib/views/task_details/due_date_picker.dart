import 'package:flutter/material.dart';
import 'package:task_management_app/task_management_app.dart';
export 'package:intl/intl.dart';

class DueDatePicker extends StatefulWidget {
  const DueDatePicker({super.key,required this.initialDateNotifier});

  final ValueNotifier<DateTime> initialDateNotifier;


  @override
  State<DueDatePicker> createState() => _DueDatePickerState();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _DueDatePickerState extends State<DueDatePicker>
    with RestorationMixin {
  @override
  String? get restorationId => 'main';

  late final RestorableDateTime _selectedDate = RestorableDateTime(widget.initialDateNotifier.value);
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: DueDatePickerConstants.restorationId,
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2024),
          lastDate: DateTime(2031),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, DueDatePickerConstants.selectedDateRestorationId);
    registerForRestoration(
        _restorableDatePickerRouteFuture, DueDatePickerConstants.datePickerRouteRestorationId);
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
      widget.initialDateNotifier.value = _selectedDate.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: Text(
        DateFormat.yMMMMd('en_US').format(_selectedDate.value),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dashed,
            decorationColor: Colors.grey,
            color: Theme.of(context).colorScheme.inverseSurface),
      ),
    );
  }
}

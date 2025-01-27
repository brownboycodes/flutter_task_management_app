import 'package:hive/hive.dart';
import 'package:task_management_app/task_management_app.dart';
part 'sort_order.g.dart';

///[SortOrder] is an enum class that represents the sort order of a list
@HiveType(typeId: 2)
enum SortOrder {
  @HiveField(0)
  dueDates(SortOrderConstants.dueDates),
  @HiveField(1)
  priority(SortOrderConstants.priority),
  @HiveField(2)
  defaultOrder(SortOrderConstants.defaultOrder);

  const SortOrder(this.label);

  ///[label] is the label of the sort order
  final String label;

  static SortOrder fromString(String? label) {
    switch (label) {
      case SortOrderConstants.dueDates:
        return SortOrder.dueDates;
      case SortOrderConstants.priority:
        return SortOrder.priority;
      default:
        return SortOrder.defaultOrder;
    }
  }
}

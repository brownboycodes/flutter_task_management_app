import 'package:hive/hive.dart';
part 'sort_order.g.dart';

///[SortOrder] is an enum class that represents the sort order of a list
@HiveType(typeId: 2)
enum SortOrder {
  @HiveField(0)
  dueDates("Due Dates"),
  @HiveField(1)
  priority("Priority"),
  @HiveField(2)
  defaultOrder("Default");

  const SortOrder(this.label);

  ///[label] is the label of the sort order
  final String label;

  static SortOrder fromString(String? label) {
    switch (label) {
      case "Due Dates":
        return SortOrder.dueDates;
      case "Priority":
        return SortOrder.priority;
      default:
        return SortOrder.defaultOrder;
    }
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortOrderAdapter extends TypeAdapter<SortOrder> {
  @override
  final int typeId = 2;

  @override
  SortOrder read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortOrder.dueDates;
      case 1:
        return SortOrder.priority;
      case 2:
        return SortOrder.defaultOrder;
      default:
        return SortOrder.dueDates;
    }
  }

  @override
  void write(BinaryWriter writer, SortOrder obj) {
    switch (obj) {
      case SortOrder.dueDates:
        writer.writeByte(0);
        break;
      case SortOrder.priority:
        writer.writeByte(1);
        break;
      case SortOrder.defaultOrder:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthItemAdapter extends TypeAdapter<HealthItem> {
  @override
  final int typeId = 0;

  @override
  HealthItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthItem(
      id: fields[0] as int,
      name: fields[1] as String,
      barcode: fields[2] as String,
      cholesterol: fields[3] as int,
      bloodGlucose: fields[4] as int,
      fat: fields[5] as int,
      protein: fields[6] as int,
      natrium: fields[7] as int,
      calorie: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HealthItem obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.barcode)
      ..writeByte(3)
      ..write(obj.cholesterol)
      ..writeByte(4)
      ..write(obj.bloodGlucose)
      ..writeByte(5)
      ..write(obj.fat)
      ..writeByte(6)
      ..write(obj.protein)
      ..writeByte(7)
      ..write(obj.natrium)
      ..writeByte(8)
      ..write(obj.calorie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

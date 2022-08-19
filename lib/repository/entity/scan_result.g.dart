// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScanResultAdapter extends TypeAdapter<ScanResult> {
  @override
  final int typeId = 1;

  @override
  ScanResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanResult(
      time: fields[0] as DateTime,
      barcode: fields[1] as String,
      result: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ScanResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.barcode)
      ..writeByte(2)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScanResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

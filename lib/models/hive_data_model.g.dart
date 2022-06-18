// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveModelDataAdapter extends TypeAdapter<HiveModelData> {
  @override
  final int typeId = 2;

  @override
  HiveModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveModelData(
      cName: fields[0] as String,
      lastdate: fields[1] as DateTime,
      fuelData: (fields[2] as List?)?.cast<FuelingDataModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveModelData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cName)
      ..writeByte(1)
      ..write(obj.lastdate)
      ..writeByte(2)
      ..write(obj.fuelData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

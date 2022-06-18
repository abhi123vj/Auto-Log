// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FuelingDataModelAdapter extends TypeAdapter<FuelingDataModel> {
  @override
  final int typeId = 3;

  @override
  FuelingDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FuelingDataModel(
      date: fields[0] as DateTime?,
      milage: fields[2] as double?,
      totalFuel: fields[3] as double,
      fuelPrice: fields[4] as double,
      odoMeterReading: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FuelingDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.milage)
      ..writeByte(3)
      ..write(obj.totalFuel)
      ..writeByte(4)
      ..write(obj.fuelPrice)
      ..writeByte(5)
      ..write(obj.odoMeterReading);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelingDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

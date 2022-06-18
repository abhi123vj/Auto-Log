// To parse this JSON data, do
//
//     final fuelingDataModel = fuelingDataModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

part 'fuel_model.g.dart';
@HiveType(typeId: 3)
class FuelingDataModel {
    FuelingDataModel({
         this.date,
        this.milage,
        required this.totalFuel,
        required this.fuelPrice,
        required this.odoMeterReading,
    });
@HiveField(0)
    DateTime? date;
    @HiveField(2)
    double? milage;
    @HiveField(3)
    double totalFuel;
    @HiveField(4)
    double fuelPrice;
    @HiveField(5)
    double odoMeterReading;

}

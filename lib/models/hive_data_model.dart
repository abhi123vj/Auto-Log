import 'package:hive/hive.dart';
import 'package:milage_calcualator/models/fuel_model.dart';

part 'hive_data_model.g.dart';

@HiveType(typeId: 2)
class HiveModelData {
  @HiveField(0)
  String cName;

  @HiveField(1)
  DateTime lastdate;

  @HiveField(2)
  List<FuelingDataModel>? fuelData;

  HiveModelData({required this.cName, required this.lastdate, this.fuelData});
}
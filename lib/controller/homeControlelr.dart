import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:milage_calcualator/constants/app_colors.dart';
import 'package:milage_calcualator/models/fuel_model.dart';
import 'package:milage_calcualator/models/hive_data_model.dart';

class HomeController extends GetxController {
  RxList fuelHistory = [].obs;
  String carName = Get.arguments[1];
  RxString updatedDate = "YTD".obs;
  RxString totalDistance = "".obs;
  RxString lowestMilage = "00".obs;
  RxString highestMilage = "00".obs;

  String carNumPlate = Get.arguments[0];
  HiveModelData carDdata =
      HiveModelData(cName: Get.arguments[1], lastdate: DateTime.now());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    log(Get.arguments.toString());
    log("message ${carName}");
    getData();
  }

  getData() async {
    var box = await Hive.openBox('carData');

    if (box.get(carNumPlate) != null) {
      carDdata = box.get(carNumPlate);
      String formattedDate =
          DateFormat('yyyy-MM-dd  hh:mm aa').format(carDdata.lastdate);
      updatedDate.value = formattedDate;
      carName = carDdata.cName;
      findBEst();
      fuelHistory.clear();
      fuelHistory.addAll(carDdata.fuelData ?? []);
    }
  }

  addTofuelData(FuelingDataModel fueldata) async {
    log("message");
    if (await validate(fueldata)) {
      try {
        carDdata.fuelData != null
            ? carDdata.fuelData?.add(fueldata)
            : carDdata.fuelData = [fueldata];

        log("message ${carDdata.fuelData?.length}");
      } catch (e) {
        log(e.toString());
      }
      await sortData();
    }
  }

  removeData(int index) {
    if (index == 0 && carDdata.fuelData?.elementAt(1) != null) {
      carDdata.fuelData!.elementAt(1).milage = null;
    }
    carDdata.fuelData!.removeAt(index);
    saveDate();
    getData();
  }

  findBEst() {
    if (carDdata.fuelData != null &&
        carDdata.fuelData!.length > 1 &&
        carDdata.fuelData?.elementAt(1).milage != null) {
      double low = carDdata.fuelData!.elementAt(1).milage as double;
      double high = carDdata.fuelData!.elementAt(1).milage as double;

      for (int i = 1; i < carDdata.fuelData!.length; i++) {
        try {
          if (low > carDdata.fuelData!.elementAt(i).milage!.toDouble()) {
            low = carDdata.fuelData!.elementAt(i).milage!.toDouble();
          }
          if (high < carDdata.fuelData!.elementAt(i).milage!.toDouble()) {
            high = carDdata.fuelData!.elementAt(i).milage!.toDouble();
          }
        } catch (e) {
          log("message $e");
        }
      }
      highestMilage.value = high.toStringAsFixed(3);
      lowestMilage.value = low.toStringAsFixed(3);
      print("hifg $high , low $low");
    }
  }

  Future sortData() async {
    carDdata.fuelData
        ?.sort((a, b) => b.odoMeterReading.compareTo(a.odoMeterReading));
    await getMilage();
    return;
  }

  Future getMilage() async {
    if (carDdata.fuelData != null && carDdata.fuelData!.length > 1) {
      for (int i = 1; i < carDdata.fuelData!.length; i++) {
        double previousDis =
            carDdata.fuelData!.elementAt(i - 1).odoMeterReading;
        double currentDis = carDdata.fuelData!.elementAt(i).odoMeterReading;
        double currentFuel = carDdata.fuelData!.elementAt(i - 1).totalFuel;
        carDdata.fuelData!.elementAt(i).milage =
            (previousDis - currentDis) / currentFuel;
        log("Milage ${carDdata.fuelData!.elementAt(i).milage}");
      }
    }
    saveDate();
    return;
  }

  Future saveDate() async {
    var box = await Hive.openBox('carData');
    box.put(carNumPlate, carDdata);
    getData();
    return;
  }

  Future validate(FuelingDataModel fueldata) async {
    log("message");
    // if (carDdata.fuelData?.elementAt(0).odoMeterReading != null &&
    //     fueldata.odoMeterReading <=
    //         carDdata.fuelData!.elementAt(0).odoMeterReading) {
    //   Get.snackbar("Distance Error!!", "Check your Reading",colorText: AppColors.cyanLight);
    //   return false;
    // }
    return true;
  }
}

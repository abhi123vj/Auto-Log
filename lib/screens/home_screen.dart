import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milage_calcualator/constants/app_colors.dart';
import 'package:milage_calcualator/controller/homeControlelr.dart';
import 'package:milage_calcualator/models/fuel_model.dart';
import 'package:milage_calcualator/screens/widgets/textField.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeController homC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
              homC.carName,
              style: const TextStyle(
                  color: AppColors.yellowDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.start,
            ),
        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cyanDark,
        onPressed: () {
          bottomSheet(context);
        },
        child: const Icon(
          Icons.create,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text(
                      "Lowest Mileage\n${homC.lowestMilage} km/hr",
                      style: const TextStyle(
                          color: AppColors.orangeDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )),
                Obx(() => Text(
                      "Highest Mileage\n${homC.highestMilage} km/hr",
                      style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: homC.fuelHistory.length,
                    itemBuilder: ((context, index) {
                      FuelingDataModel data =
                          homC.fuelHistory.elementAt(index) as FuelingDataModel;

                      String formattedDate = DateFormat('yyyy-MM-dd  hh:mm aa')
                          .format(data.date ?? DateTime.now());
                      return Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: InkWell(
                          onTap: () {
                            bottomSheet(
                              context,
                              index,
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(18)),
                                    border: Border.all(
                                        color: AppColors.yellowDark, width: 1),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.center,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${data.odoMeterReading} Km",
                                                style: const TextStyle(
                                                    color: AppColors.cyanDark,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                "\u{20B9} ${(data.totalFuel * data.fuelPrice).toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    color: AppColors.cyanNormal,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w800),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                          const Spacer(),
                                          data.milage != null
                                              ? Text(
                                                  "${data.milage?.toStringAsFixed(2)} Km/L",
                                                  style: const TextStyle(
                                                      color:
                                                          AppColors.orangeLight,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                  textAlign: TextAlign.center,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    }))))
          ],
        ),
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context, [int? index]) async {
    final TextEditingController odoReading = TextEditingController();
    final TextEditingController fuelFIlled = TextEditingController();
    final TextEditingController fuelPrice = TextEditingController();
    if (index != null) {
      odoReading.text =
          homC.carDdata.fuelData!.elementAt(index).odoMeterReading.toString();
           fuelFIlled.text =
          homC.carDdata.fuelData!.elementAt(index).totalFuel.toString();
               fuelPrice.text =
          homC.carDdata.fuelData!.elementAt(index).fuelPrice.toString();
    }
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.blackGlaze,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                BoarderTextField(
                    controller: fuelPrice, hintText: AppString.fuelPrice),
                BoarderTextField(
                    controller: fuelFIlled, hintText: AppString.fuelTotal),
                BoarderTextField(
                    controller: odoReading, hintText: AppString.odoReading),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (fuelFIlled.text.isNotEmpty ||
                                fuelPrice.text.isNotEmpty ||
                                odoReading.text.isNotEmpty) {
                              FuelingDataModel fueldata = FuelingDataModel(
                                date: DateTime.now(),
                                totalFuel: double.parse(fuelFIlled.text),
                                fuelPrice: double.parse(fuelPrice.text),
                                odoMeterReading: double.parse(odoReading.text),
                              );
                              if(index!=null){
                                 homC.removeData(index);
                              }
                              homC.addTofuelData(fueldata);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            AppString.add,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              primary: AppColors.cyanDark,
                              shape: const StadiumBorder()),
                        ),
                      ),
                    ),
                  ],
                ),
                if(index!=null)
                 Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only( bottom: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (fuelFIlled.text.isNotEmpty ||
                                fuelPrice.text.isNotEmpty ||
                                odoReading.text.isNotEmpty) {
                              
                              homC.removeData(index);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            AppString.delete,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 4.w),
                              primary: AppColors.cyanDark,
                              shape: const StadiumBorder()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:milage_calcualator/constants/app_strings.dart';
import 'package:sizer/sizer.dart';

import '../constants/app_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController carNameController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.appName,
          style: TextStyle(
              color: AppColors.yellowDark,
              fontSize: 20,
              fontWeight: FontWeight.w800),
          textAlign: TextAlign.start,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppString.lgoinHeader1,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 30.h,
                child: ValueListenableBuilder<Box>(
                  valueListenable: Hive.box('carList').listenable(),
                  builder: (context, box, widget) {
                    List data = [];
                    data.clear();
                    for (var index in box.keys) {
                      try {
                        var carData = box.get(index);
                        var boxIndex = index;
                        data.add({'carData': carData, 'index': boxIndex});
                      } catch (e) {
                        log("message $e");
                      }
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          List carLsit = data.elementAt(index)['carData'];
                          String str = '${index + 1}.';
                          return Container(
                            margin: const EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.cyanDark.withOpacity(.8),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(18)),
                            ),
                            child: InkWell(
                              onLongPress: () {
                                box.delete(data.elementAt(index)['index']);
                              },
                              onTap: () {
                                Get.toNamed('/',
                                    arguments: [carLsit[0], carLsit[1]]);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    str.padRight(2, '4'),
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    " ${carLsit[1]}",
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    " ${carLsit[0]}",
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
              Divider(
                height: 50,
                thickness: 1,
                color: AppColors.orangeLight.withOpacity(.5),
              ),
              const Text(
                AppString.create,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  border: Border.all(color: AppColors.yellowDark, width: 1),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: carNumberController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.yellowPale),
                      hintText: AppString.vehicleNumber),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                  border: Border.all(color: AppColors.yellowDark, width: 1),
                ),
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  controller: carNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.yellowPale),
                      hintText: AppString.vehicleName),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (carNameController.text.isNotEmpty &&
                              carNumberController.text.isNotEmpty) {
                            var carsList =
                                await Hive.openBox(AppString.carList);
                            carsList.put( carNumberController.text,[
                              carNumberController.text,
                              carNameController.text
                            ]);
                            Get.toNamed('/', arguments: [
                              carNumberController.text,
                              carNameController.text
                            ]);
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
            ],
          ),
        ),
      ),
    );
  }
}

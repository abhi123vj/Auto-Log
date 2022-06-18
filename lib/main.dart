import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:milage_calcualator/constants/app_strings.dart';
import 'package:milage_calcualator/routes/route.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'models/fuel_model.dart';
import 'models/hive_data_model.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(FuelingDataModelAdapter());

  Hive.registerAdapter(HiveModelDataAdapter());

  await Hive.openBox(AppString.carData);
  await Hive.openBox(AppString.carList);

  runApp(Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialPage,
        getPages: AppRoutes.pages);
  }));
}

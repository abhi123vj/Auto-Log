import 'package:get/get.dart';
import 'package:milage_calcualator/screens/login_screen.dart';

import '../screens/home_screen.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: '/',
      page: () => HomeScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
  ];
  static String initialPage = pages.elementAt(1).name;

  static String homeRoute = '/';
    static String loginRoute = '/login';

}

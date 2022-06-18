import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import 'appbar_theme.dart';

class AppTheme {
  static final theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.cyanNormal,
      backgroundColor: AppColors.blackGlaze,
      scaffoldBackgroundColor: AppColors.blackGlaze,
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            padding:  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20)),
              foregroundColor: MaterialStateProperty.all<Color>(
        AppColors.cyanNormal,
      ))),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.openSansTextTheme().apply(
        bodyColor: AppColors.white,
        //displayColor: Colors.blue,
      ),
      appBarTheme: CustomAppBarTheme.theme);
}

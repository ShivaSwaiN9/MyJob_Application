import 'package:flutter/material.dart';
import 'package:my_job_flutter/app_configs/environment.dart';

import 'app_colors.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: Environment.fontFamily,
    canvasColor: AppColors.brightBackground,
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    backgroundColor: AppColors.brightBackground,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
}

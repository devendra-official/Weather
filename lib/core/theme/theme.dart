import 'package:flutter/material.dart';
import 'package:weather/core/theme/app_pallete.dart';

ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: AppPallete.appThemeColor
  ),
  scaffoldBackgroundColor: AppPallete.appThemeColor,
  brightness: Brightness.dark,
  useMaterial3: true,
);

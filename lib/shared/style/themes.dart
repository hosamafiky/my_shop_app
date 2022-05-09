import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/style/colors.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Metropolis',
  primarySwatch: Colors.red,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF9F9F9),
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      color: Color(0xFF222222),
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedLabelStyle: TextStyle(
      color: Colors.red,
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: TextStyle(
      color: Color(0xFF9B9B9B),
      fontSize: 10.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    floatingLabelStyle: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11.0,
      color: Color(0xFF9B9B9B),
    ),
    hintStyle: TextStyle(
      color: Color(0xFF9B9B9B),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    labelStyle: TextStyle(
      color: Color(0xFF9B9B9B),
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: TextStyle(fontWeight: FontWeight.w500),
    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
  ),
);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
);

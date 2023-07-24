import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color.dart';

ThemeData lightthem=ThemeData(
  primarySwatch:defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight:FontWeight.bold
      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      elevation: 0,
      // backwardsCompatibility: false,
      systemOverlayStyle:(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ))
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:defaultColor,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
    subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black
    ),
  ),

);

ThemeData? darkthem= ThemeData(
  scaffoldBackgroundColor:HexColor('333739'),
  primarySwatch:defaultColor,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: HexColor('333739'),
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      elevation: 0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight:FontWeight.bold
      ),
      // backwardsCompatibility: false,
      systemOverlayStyle:(SystemUiOverlayStyle(
        statusBarColor:HexColor('333739'),
        statusBarIconBrightness:Brightness.light,
      ))

  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('333739'),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor:defaultColor,

  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white
    ),
  ),
);
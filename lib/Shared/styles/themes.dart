import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/Shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch:defaultColor,
  scaffoldBackgroundColor: HexColor('7B7A7D') ,
  appBarTheme: AppBarTheme(
    titleSpacing: 8,
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor:HexColor('7B7A7D'),
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor:HexColor('7B7A7D'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color:Color(0xffffffff),
      fontSize: 26,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
    iconTheme: IconThemeData(
      color:Colors.white,
    ),

  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: HexColor('9F86D0'),
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:HexColor('9F86D0') ,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    backgroundColor: HexColor('7B7A7D'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme =ThemeData(
  //loading circle
  primarySwatch:defaultColor,
  //background body
  scaffoldBackgroundColor: HexColor('EFF3E2') ,
  appBarTheme: AppBarTheme(
    titleSpacing: 8,
    backwardsCompatibility: false,
    systemOverlayStyle:SystemUiOverlayStyle(
      //nav mobile
      statusBarColor: HexColor('F0F1EA'),
      statusBarBrightness: Brightness.dark,
    ),
    // appar background
    backgroundColor:HexColor('CEE397'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color:Color(0xffffffff),
      fontSize: 26,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
    iconTheme: IconThemeData(
      color:Colors.white,
    ),
  ),
  //circle button
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: HexColor('B2C9AB'),
  // ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:HexColor('CEE397') ,
    unselectedItemColor: Colors.grey,
    elevation: 20,
    //navdown background
    backgroundColor: HexColor('F0F1EA'),
    // backgroundColor:  HexColor('7B7A7D'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),

);




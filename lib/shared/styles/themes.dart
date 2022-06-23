import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primaryColorLight: Colors.black,
  primaryTextTheme: TextTheme(
      headline4: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
  textTheme: TextTheme(headline3: TextStyle(color: Colors.black)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(color: Colors.black),
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue,
  ),
  scaffoldBackgroundColor: HexColor('ffffff'),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.0),
    iconTheme: IconThemeData(color: Colors.blue),
    actionsIconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    backgroundColor: HexColor('ffffff'),
  ),
);

ThemeData darkTheme = ThemeData(primarySwatch: Colors.grey);

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTheme {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  static final dark = ThemeData(
    disabledColor: Colors.white,
    canvasColor: Color(0xff1E1E1E),
    backgroundColor: Colors.black,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xff1E1E1E),
    ),
  );
  static final light = ThemeData(
    disabledColor: Colors.lightBlueAccent,
    canvasColor: Colors.white,
    backgroundColor: Colors.lightBlueAccent,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.lightBlueAccent,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlueAccent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );
}

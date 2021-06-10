import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences prefs;
  final String key = "theme";
  bool darkmode;
  ThemeMode themeMode;

  ThemeProvider() {
    darkmode = true;
    getPreference();
  }

  initPreference() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
  }

  getPreference() async {
    await initPreference();
    darkmode = prefs.getBool(key) ?? true;
    themeMode = darkmode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  savePreference() async {
    await initPreference();
    await prefs.setBool(key, darkmode);
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    darkmode = isOn;
    await savePreference();
    notifyListeners();
  }
}

class MyTheme {
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

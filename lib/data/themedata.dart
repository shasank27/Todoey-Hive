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
    accentColor: Colors.white,
    highlightColor: Colors.white38,
    hintColor: Color(545454),
    disabledColor: Colors.white,
    canvasColor: Color(0xff686767),
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
      backgroundColor: Color(0xff686767),
    ),
  );
  static final light = ThemeData(
    accentColor: Colors.white,
    highlightColor: Color(0x73000000),
    hintColor: Color(803137),
    disabledColor: Color(0xffFF616D),
    canvasColor: Colors.white,
    backgroundColor: Color(0xffFF616D),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Color(0xffFF616D),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xffFF616D)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xffFF616D),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );
}

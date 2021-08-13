import 'package:b/Home/Storage_Manager.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {

 static bool mode = true ;
 final lightTheme =  ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.grey,
  );
   final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.grey,
  );


  ThemeData _themeData;

  ThemeData getTheme() {
    return _themeData;
  }

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

import 'package:music_player_app/themes/dark_mode.dart';
import 'package:music_player_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  //initially, it's light mode

  ThemeData _themeData = lightMode;

  // get the theme
  ThemeData get themeData => _themeData;

  // is the dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set the theme
  set themeData(ThemeData themedata) {
    _themeData = themedata;

    //update the UI

    notifyListeners();
  }

  // toggle theme
  void toggleTheme() {
    if (_themeData == lightMode) { // if the current theme is light mode
      themeData = darkMode;    // change to dark mode 
    } else {
      themeData = lightMode;  // otherway around
    }
  }
}

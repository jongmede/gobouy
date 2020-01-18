import 'package:flutter/material.dart';

class DynamicTheme with ChangeNotifier {
  // ChangeNotifier : will provide a notifier for any changes in the value to all it's listeners
  bool isDarkMode = false;
  getDarkMode() => this.isDarkMode;

  void changeDarkMode(isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}
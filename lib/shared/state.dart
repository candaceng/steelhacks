import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier{
  bool isDark = false;
  void updateTheme(bool isDark) {
    this.isDark = isDark;
    notifyListeners();
  }
}
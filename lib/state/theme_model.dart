import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get modeGelap => _themeMode == ThemeMode.dark;

  void ubahTema(bool aktif) {
    _themeMode = aktif
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }
}

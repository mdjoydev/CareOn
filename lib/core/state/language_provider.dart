import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  bool _isBangla = false;

  bool get isBangla => _isBangla;

  set isBangla(bool value) {
    _isBangla = value;
    notifyListeners();
  }

  void toggleLanguage() {
    _isBangla = !_isBangla;
    notifyListeners();
  }
}

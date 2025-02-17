import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isLoading = false;
  bool _isDarkMode = false;
  String _bloodType = 'O+';

  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;
  String get bloodType => _bloodType;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateBloodType(String type) {
    _bloodType = type;
    notifyListeners();
  }
}
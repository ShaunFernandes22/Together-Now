import 'package:flutter/material.dart';

class ChoiceStateProvider extends ChangeNotifier {
  int _selectedIndex = -1; // Default to no selection
  String _selectedChoice = ''; // Default selected choice

  int get selectedIndex => _selectedIndex;
  String get selectedChoice => _selectedChoice;

  void selectButton(int index, String choice) {
    _selectedIndex = index;
    _selectedChoice = choice;
    notifyListeners();
  }
}

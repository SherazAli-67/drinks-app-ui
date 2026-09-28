import 'package:drinks_app/core/app_data.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:flutter/material.dart';

class DrinkDetailProvider extends ChangeNotifier {
  DrinkDetailProvider(String drinkId) : drink = AppData.drinkById(drinkId)!;

  final DrinkModel drink;
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}

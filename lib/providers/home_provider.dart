import 'package:drinks_app/core/app_data.dart';
import 'package:drinks_app/models/category_model.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  final mixesController = PageController(viewportFraction: 0.72);

  String _query = '';
  int _currentMixIndex = 0;

  int get currentMixIndex => _currentMixIndex;

  List<CategoryModel> get categories {
    if (_query.isEmpty) return AppData.categories;
    return AppData.categories.where((c) => c.name.toLowerCase().contains(_query)).toList();
  }

  List<DrinkModel> get recentMixes {
    if (_query.isEmpty) return AppData.recentMixes;
    return AppData.recentMixes.where((d) => d.name.toLowerCase().contains(_query) || d.category.toLowerCase().contains(_query)).toList();
  }

  void updateQuery(String value) {
    _query = value.trim().toLowerCase();
    _currentMixIndex = 0;
    if (mixesController.hasClients) mixesController.jumpToPage(0);
    notifyListeners();
  }

  void setCurrentMixIndex(int index) {
    _currentMixIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    mixesController.dispose();
    super.dispose();
  }
}

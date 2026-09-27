import 'package:drinks_app/models/ingredient_model.dart';

class DrinkModel {
  const DrinkModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.timeMinutes,
    required this.difficulty,
    required this.flavor,
    required this.serves,
    required this.likes,
    required this.rating,
    required this.heroImage,
    required this.ingredients,
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final int timeMinutes;
  final String difficulty;
  final String flavor;
  final int serves;
  final int likes;
  final double rating;
  final String heroImage;
  final List<IngredientModel> ingredients;
}

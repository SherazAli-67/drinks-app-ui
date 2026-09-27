import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/models/category_model.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:drinks_app/models/ingredient_model.dart';

class AppData {
  AppData._();

  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'cocktails',
      name: 'Cocktails',
      mixCount: 50,
      imageAsset: AssetRes.imgCategoryCocktails,
    ),
    CategoryModel(
      id: 'mocktails',
      name: 'Mocktails',
      mixCount: 39,
      imageAsset: AssetRes.imgCategoryMocktails,
    ),
    CategoryModel(
      id: 'shakes',
      name: 'Shakes',
      mixCount: 48,
      imageAsset: AssetRes.imgCategoryShakes,
    ),
    CategoryModel(
      id: 'long-drinks',
      name: 'Long drinks',
      mixCount: 21,
      imageAsset: AssetRes.imgCategoryLongDrinks,
    ),
  ];

  static const List<IngredientModel> virginMojitoIngredients = [
    IngredientModel(
      name: 'Mint Leaves',
      quantity: '8',
      imageAsset: AssetRes.imgIngredientMint,
    ),
    IngredientModel(
      name: 'Lemon Wedges',
      quantity: '2',
      imageAsset: AssetRes.imgIngredientLemonWedges,
    ),
    IngredientModel(
      name: 'Lemon Juice',
      quantity: '30',
      unit: 'ml',
      imageAsset: AssetRes.imgIngredientLemonJuice,
    ),
    IngredientModel(
      name: 'Ice Cubes',
      quantity: '6',
      imageAsset: AssetRes.imgIngredientIce,
    ),
    IngredientModel(
      name: 'Sugar',
      quantity: '2',
      unit: 'tbsp',
      imageAsset: AssetRes.imgIngredientSugar,
    ),
    IngredientModel(
      name: 'Club Soda',
      quantity: '30',
      unit: 'ml',
      imageAsset: AssetRes.imgIngredientClubSoda,
    ),
  ];

  static const List<DrinkModel> drinks = [
    DrinkModel(
      id: 'blue-moon',
      name: 'Blue Moon',
      description:
          'A vibrant blue mocktail with citrus notes, perfect for warm evenings.',
      category: 'Mocktail',
      timeMinutes: 20,
      difficulty: 'Easy',
      flavor: 'Sweet',
      serves: 2,
      likes: 534,
      rating: 4.0,
      heroImage: AssetRes.imgDrinkBlueMoon,
      ingredients: [],
    ),
    DrinkModel(
      id: 'whisky-tumbler',
      name: 'Whisky Tumbler',
      description:
          'A classic whisky serve over ice in a short tumbler glass.',
      category: 'Cocktail',
      timeMinutes: 5,
      difficulty: 'Easy',
      flavor: 'Strong',
      serves: 1,
      likes: 312,
      rating: 4.5,
      heroImage: AssetRes.imgDrinkWhiskyTumbler,
      ingredients: [],
    ),
    DrinkModel(
      id: 'virgin-mojito',
      name: 'Virgin Mojito',
      description:
          'A Mojito without alcohol, its combination of sweet and citrusy flavors makes it the summers go to.',
      category: 'Mocktail',
      timeMinutes: 25,
      difficulty: 'Medium',
      flavor: 'Sweet',
      serves: 2,
      likes: 890,
      rating: 4.5,
      heroImage: AssetRes.imgDrinkVirginMojito,
      ingredients: virginMojitoIngredients,
    ),
  ];

  static List<DrinkModel> get recentMixes => [
        drinks[0],
        drinks[1],
      ];

  static DrinkModel? drinkById(String id) {
    for (final drink in drinks) {
      if (drink.id == id) return drink;
    }
    return null;
  }
}

class IngredientModel {
  const IngredientModel({
    required this.name,
    required this.quantity,
    required this.imageAsset,
    this.unit,
  });

  final String name;
  final String quantity;
  final String? unit;
  final String imageAsset;
}

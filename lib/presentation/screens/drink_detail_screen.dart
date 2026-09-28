import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:drinks_app/core/app_data.dart';
import 'package:drinks_app/core/app_textstyles.dart';
import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:drinks_app/models/ingredient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DrinkDetailScreen extends StatefulWidget {
  final String drinkId;
  const DrinkDetailScreen({super.key, required this.drinkId});

  @override
  State<DrinkDetailScreen> createState() => _DrinkDetailScreenState();
}

class _DrinkDetailScreenState extends State<DrinkDetailScreen> {
  bool _isFavorite = false;
  late DrinkModel drink;

  @override
  void initState() {
    super.initState();
    drink = AppData.drinkById(widget.drinkId)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: .start,
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: .fromLTRB(17 , 10 , 24 , 24 ),
              child: Column(
                crossAxisAlignment: .start,
                spacing: 12 ,
                children: [
                  Row(
                    mainAxisSize: .min,
                    spacing: 10 ,
                    children: [
                      Text(StringConst.ingredients, style: AppTextStyles.ingredientsHeader.copyWith(height: 1.2)),
                      Transform.flip(
                        flipX: true,
                        child: SvgPicture.asset(AssetRes.icChevronPink, width: 7 , height: 14 ),
                      ),
                    ],
                  ),
                  Expanded(child: _buildIngredientsList()),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: .bottomEnd,
      children: [
        Container(
          width: .infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AssetRes.icDetailWave),fit: .cover)
          ),
          padding: .only(bottom: 48 ),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: .symmetric(horizontal: 34 , vertical: 8 ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: SvgPicture.asset(AssetRes.icBack, width: 9 , height: 16 ),
                      ),
                      Expanded(child: Text(drink.name, style: AppTextStyles.drinkTitle, textAlign: .center)),
                      GestureDetector(
                        onTap: () => setState(() => _isFavorite = !_isFavorite),
                        child: _isFavorite ? Icon(Icons.favorite_rounded, color: AppColors.pink,) : Icon(Icons.favorite_border_rounded)
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: .symmetric(horizontal: 34 ),
                  child: Text(drink.description, style: AppTextStyles.drinkDescription),
                ),
                SizedBox(height: 16 ),
                SizedBox(
                  height: 304,
                  child: Padding(
                    padding: .only(left: 44 ),
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 10 ,
                      children: [
                        _buildMetaBlock(
                          label: StringConst.time,
                          value: '${drink.timeMinutes} ${StringConst.minSuffix}',
                          color: AppColors.navy,
                        ),
                        _buildMetaBlock(
                          label: StringConst.difficulty,
                          value: drink.difficulty,
                          color: AppColors.lime,
                        ),
                        _buildMetaBlock(
                          label: StringConst.category,
                          value: drink.flavor,
                          color: AppColors.orange,
                        ),
                        _buildMetaBlock(
                          label: StringConst.serves,
                          value: '${drink.serves}',
                          color: AppColors.pink,
                          isServes: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 150,
            right: -50,
            child: Image.asset(drink.heroImage, fit: .cover,))
      ],
    );
  }

  Widget _buildMetaBlock({
    required String label,
    required String value,
    required Color color,
    bool isServes = false,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(label, style: AppTextStyles.metaLabel.copyWith(color: color, height: 1.2)),
        Text(value, style: (isServes ? AppTextStyles.metaServesValue : AppTextStyles.metaValue).copyWith(color: color, height: 1.15),),
      ],
    );
  }

  Widget _buildIngredientsList() {
    List<IngredientModel> ingredients = drink.ingredients;
    if (ingredients.isEmpty) return const SizedBox.shrink();
    return GridView.builder(
      itemCount: ingredients.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 16, crossAxisSpacing: 10, childAspectRatio: 0.95),
        itemBuilder: (ctx, index){
        final ingredient = ingredients[index];
        final nameParts = ingredient.name.split(' ');
        return Container(
          decoration: BoxDecoration(
              shape: .circle,
              border: .all(color: AppColors.strokeColor.withValues(alpha: 0.7)),
              color: AppColors.cream
          ),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 5,
            children: [
              Image.asset(ingredient.imageAsset,),
              Row(
                mainAxisSize: .min,
                spacing: 4,
                crossAxisAlignment: .start,
                children: [
                  Text(ingredient.quantity, style:  AppTextStyles.ingredientQuantity.copyWith(fontSize: ingredient.unit == null ? 28  : 24 , height: 1,)),
                  Text(
                    nameParts.join('\n'),
                    style: AppTextStyles.ingredientName.copyWith(height: 1.15),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ],
              )
            ],
          ),
        );
      });
  }
}
import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:drinks_app/core/app_textstyles.dart';
import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/models/category_model.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:drinks_app/providers/home_provider.dart';
import 'package:drinks_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 24),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 18,
                  children: [
                    _buildHeader(),
                    Text(StringConst.homePrompt, style: AppTextStyles.homePrompt),
                    _buildSearchField(context),
                    _buildSectionHeader(title: StringConst.categories),
                  ],
                ),
              ),
              SizedBox(height: 12),
              _buildCategories(context),
              SizedBox(height: 20),
              Padding(
                padding: .symmetric(horizontal: 24),
                child: _buildSectionHeader(title: StringConst.recentMixes),
              ),
              SizedBox(height: 14),
              _buildRecentMixes(context),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Padding(
      padding: .only(top: 8),
      child: Row(
        children: [
          SvgPicture.asset(AssetRes.icDrawerMenu, width: 24, height: 24),
          const Spacer(),
          Row(
            mainAxisSize: .min,
            children: [
              Image.asset(AssetRes.imgDrinkoLogo, height: 28, fit: .contain),
              Transform.rotate(
                angle: 0.42,
                child: Text(StringConst.logoO, style: TextStyle(fontSize: 22, color: AppColors.scriptPink, height: 1)),
              ),
            ],
          ),
          const Spacer(),
          ClipOval(
            child: Image.asset(AssetRes.imgAvatar, width: 24, height: 24, fit: .cover),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return Container(
      height: 35,
      padding: .symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(8),
        boxShadow: [
          BoxShadow(color: AppColors.navy.withValues(alpha: 0.08), offset: const Offset(2, 0), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.searchController,
              style: AppTextStyles.searchHint.copyWith(color: AppColors.navy),
              decoration: InputDecoration(
                isDense: true,
                border: .none,
                hintText: StringConst.search,
                hintStyle: AppTextStyles.searchHint,
                contentPadding: .zero,
              ),
              onChanged: provider.updateQuery,
            ),
          ),
          SvgPicture.asset(AssetRes.icSearch, width: 14, height: 14),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title}) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
        Container(
          alignment: .center,
          padding: .symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: .circular(8),
            border: .all(color: AppColors.pink.withValues(alpha: 0.25)),
            boxShadow: [
              BoxShadow(color: AppColors.pinkMid.withValues(alpha: 0.2), offset: const Offset(2, 4), blurRadius: 15),
            ],
          ),
          child: Text(StringConst.seeAll, style: AppTextStyles.seeAll),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = context.watch<HomeProvider>().categories;
    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: .horizontal,
        padding: .symmetric(horizontal: 24),
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 12),
        itemBuilder: (context, index) => _buildCategoryCard(categories[index]),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryModel category) {
    return Container(
      padding: .symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: .circular(12),
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(category.imageAsset, fit: .contain)),
          Text(category.name, style: AppTextStyles.categoryName.copyWith(height: 1.2), maxLines: 1, overflow: .ellipsis),
          Text('${category.mixCount} ${StringConst.mixesSuffix}', style: AppTextStyles.categoryCount.copyWith(height: 1.2)),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildRecentMixes(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final mixes = provider.recentMixes;
    if (mixes.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 360,
      child: PageView.builder(
        controller: provider.mixesController,
        itemCount: mixes.length,
        padEnds: false,
        onPageChanged: provider.setCurrentMixIndex,
        itemBuilder: (context, index) => Padding(
          padding: .only(left: index == 0 ? 24 : 8, right: 8),
          child: Align(
            alignment: .topLeft,
            child: AnimatedScale(
              scale: index == provider.currentMixIndex ? 1 : 0.92,
              duration: const Duration(milliseconds: 220),
              child: _buildMixCard(context, mixes[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMixCard(BuildContext context, DrinkModel drink) {
    const cardWidth = 248.0;
    const cardHeight = 334.0;
    final nameParts = drink.name.split(' ');
    final firstLine = nameParts.first;
    final secondLine = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return GestureDetector(
      onTap: () => context.push('${NamedRoutes.drinkDetail.routeName}/${drink.id}'),
      child: SizedBox(
        width: cardWidth + 24,
        height: cardHeight + 26,
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned(
              left: 46,
              top: 130,
              child: Container(
                width: cardWidth - 88,
                height: cardHeight - 88,
                decoration: BoxDecoration(color: AppColors.pinkLight, borderRadius: .circular(16)),
              ),
            ),
            Positioned(
              left: 23,
              top: 67,
              child: Container(
                width: cardWidth - 44,
                height: cardHeight - 45,
                decoration: BoxDecoration(color: AppColors.pinkMid, borderRadius: .circular(16)),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: cardWidth,
                height: cardHeight,
                decoration: BoxDecoration(color: AppColors.pink, borderRadius: .circular(16)),
                padding: .fromLTRB(12, 20, 12, 16),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(firstLine, style: AppTextStyles.mixCardTitle),
                        if (secondLine.isNotEmpty) Text(secondLine, style: AppTextStyles.mixCardTitleSecondary),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            SvgPicture.asset(AssetRes.icDrink, width: 28, height: 28),
                            Text(drink.category, style: AppTextStyles.mixCardCategory),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 4,
                                children: [
                                  SvgPicture.asset(AssetRes.icClock, width: 22, height: 22),
                                  Text('${drink.timeMinutes} ${StringConst.minSuffix}', style: AppTextStyles.mixCardMeta),
                                ],
                              ),
                            ),
                            Text(drink.difficulty, style: AppTextStyles.mixCardMeta),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 7,
                                children: [
                                  SvgPicture.asset(AssetRes.icHeart, width: 18, height: 16),
                                  Text('${drink.likes}', style: AppTextStyles.mixCardMeta),
                                ],
                              ),
                            ),
                            _buildRatingBadge(drink.rating),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -15,
              top: -10,
              child: Image.asset(drink.heroImage, fit: .cover, height: 250),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    final filled = rating.round().clamp(0, 4);
    return Container(
      padding: .all(6),
      decoration: BoxDecoration(
        color: AppColors.starBadge,
        borderRadius: .circular(16),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 2,
        children: List.generate(
          4,
              (index) => Opacity(
            opacity: index < filled ? 1 : 0.35,
            child: SvgPicture.asset(AssetRes.icStarFilled, width: 16, height: 16),
          ),
        ),
      ),
    );
  }
}
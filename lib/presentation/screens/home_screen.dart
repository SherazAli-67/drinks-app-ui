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
                    //wantToLearnPrompt, homePrompt

                    //_buildSearchField

                    //buildSectionHeader
                  ],
                ),
              ),
              SizedBox(height: 12),
              _buildCategories(context),
              SizedBox(height: 20),
              Padding(
                padding: .symmetric(horizontal: 24),

                // child: _buildSectionHeader(title: StringConst.recentMixes),
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
          // icDrawerMenu
          const Spacer(),
          Row(
            mainAxisSize: .min,
            children: [
              //imgDrinkLogo, 38,
              Transform.rotate(
                angle: 0.42,
                //logo0, fontSize:22, scriptPink
                child: const SizedBox()
              ),
            ],
          ),
          const Spacer(),
          ClipOval(
            //imgAvatar, width: 30
            child: const SizedBox()
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
        // color: AppColors.cream,
        borderRadius: .circular(12),
      ),
      child: Column(
        children: [
          //category.imageAsset
          Expanded(child: const SizedBox()),
          //category.name, categoryName.height: 1.2

          //${category.mixCount} ${StringConst.mixesSuffix}, categoryCount.height: 1.2
          // SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildRecentMixes(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final mixes = provider.recentMixes;
    if (mixes.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 400,
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
    const cardWidth = 260.0;
    const cardHeight = 370.0;
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
                // decoration: BoxDecoration(color: AppColors.pinkLight, borderRadius: .circular(16)),
              ),
            ),
            Positioned(
              left: 23,
              top: 67,
              child: Container(
                width: cardWidth - 44,
                height: cardHeight - 45,
                // decoration: BoxDecoration(color: AppColors.pinkMid, borderRadius: .circular(16)),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: cardWidth,
                height: cardHeight,
                // decoration: BoxDecoration(color: AppColors.pink, borderRadius: .circular(16)),
                padding: .fromLTRB(12, 20, 12, 16),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        //firstLine, mixCardTitle
                        if (secondLine.isNotEmpty)
                          //secondLine, mixCardTitleSecondary
                          const SizedBox(),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            //icDrink,

                            //drink.category, mixCardCategory
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 4,
                                children: [
                                  //icClock

                                  //${drink.timeMinutes} ${StringConst.minSuffix}, mixCardMeta
                                ],
                              ),
                            ),
                            //drink.difficulty, mixCardMeta
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 7,
                                children: [
                                  //icHeart
                                  //${drink.likes}, mixCardMeta
                                ],
                              ),
                            ),
                            // _buildRatingBadge(drink.rating),
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
              //drink.heroImage, height: 300
              child: const SizedBox()
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
import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:drinks_app/core/app_data.dart';
import 'package:drinks_app/core/app_textstyles.dart';
import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/models/category_model.dart';
import 'package:drinks_app/models/drink_model.dart';
import 'package:drinks_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _designWidth = 375.0;
  final _searchController = TextEditingController();
  late final PageController _mixesController = PageController(viewportFraction: 0.72);
  String _query = '';
  int _currentMixIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _mixesController.dispose();
    super.dispose();
  }

  List<CategoryModel> get _categories {
    if (_query.isEmpty) return AppData.categories;
    return AppData.categories.where((c) => c.name.toLowerCase().contains(_query)).toList();
  }

  List<DrinkModel> get _recentMixes {
    if (_query.isEmpty) return AppData.recentMixes;
    return AppData.recentMixes.where((d) => d.name.toLowerCase().contains(_query) || d.category.toLowerCase().contains(_query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.sizeOf(context).width / _designWidth;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .only(bottom: 24 * scale),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: .symmetric(horizontal: 24 * scale),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 18 * scale,
                  children: [
                    _buildHeader(scale),
                    Text(StringConst.homePrompt, style: AppTextStyles.homePrompt),
                    _buildSearchField(scale),
                    _buildSectionHeader(title: StringConst.categories, scale: scale),
                  ],
                ),
              ),
              SizedBox(height: 12 * scale),
              _buildCategories(scale),
              SizedBox(height: 20 * scale),
              Padding(
                padding: .symmetric(horizontal: 24 * scale),
                child: _buildSectionHeader(title: StringConst.recentMixes, scale: scale),
              ),
              SizedBox(height: 14 * scale),
              _buildRecentMixes(scale),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double scale) {
    return Padding(
      padding: .only(top: 8 * scale),
      child: Row(
        children: [
          SvgPicture.asset(AssetRes.icDrawerMenu, width: 24 * scale, height: 24 * scale),
          const Spacer(),
          Row(
            mainAxisSize: .min,
            children: [
              Image.asset(AssetRes.imgDrinkoLogo, height: 28 * scale, fit: .contain),
              Transform.rotate(
                angle: 0.42,
                child: Text(
                  StringConst.logoO,
                  style: TextStyle(fontSize: 22 * scale, color: AppColors.scriptPink, height: 1),
                ),
              ),
            ],
          ),
          const Spacer(),
          ClipOval(
            child: Image.asset(AssetRes.imgAvatar, width: 24 * scale, height: 24 * scale, fit: .cover),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(double scale) {
    return Container(
      height: 35 * scale,
      padding: .symmetric(horizontal: 12 * scale),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(8 * scale),
        boxShadow: [
          BoxShadow(color: AppColors.navy.withValues(alpha: 0.08), offset: const Offset(2, 0), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: AppTextStyles.searchHint.copyWith(color: AppColors.navy),
              decoration: InputDecoration(
                isDense: true,
                border: .none,
                hintText: StringConst.search,
                hintStyle: AppTextStyles.searchHint,
                contentPadding: .zero,
              ),
              onChanged: (value) => setState(() {
                _query = value.trim().toLowerCase();
                _currentMixIndex = 0;
                if (_mixesController.hasClients) _mixesController.jumpToPage(0);
              }),
            ),
          ),
          SvgPicture.asset(AssetRes.icSearch, width: 14 * scale, height: 14 * scale),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required double scale}) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.sectionTitle)),
        Container(
          alignment: .center,
          padding: .symmetric(horizontal: 6, ),
          decoration: BoxDecoration(
            borderRadius: .circular(8 * scale),
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

  Widget _buildCategories(double scale) {
    final categories = _categories;
    return SizedBox(
      height: 112 * scale,
      child: ListView.separated(
        scrollDirection: .horizontal,
        padding: .symmetric(horizontal: 24 * scale),
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 12 * scale),
        itemBuilder: (context, index) => _buildCategoryCard(categories[index], scale),
      ),
    );
  }

  Widget _buildCategoryCard(CategoryModel category, double scale) {
    return Container(
      padding: .symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: .circular(12 * scale),
      ),
      child: Column(
        children: [
          Expanded(child: Image.asset(category.imageAsset, fit: .contain)),
          Text(category.name, style: AppTextStyles.categoryName.copyWith(height: 1.2), maxLines: 1, overflow: .ellipsis),
          Text('${category.mixCount} ${StringConst.mixesSuffix}', style: AppTextStyles.categoryCount.copyWith(height: 1.2)),
          SizedBox(height: 6 * scale),
        ],
      ),
    );
  }

  Widget _buildRecentMixes(double scale) {
    final mixes = _recentMixes;
    if (mixes.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 360 * scale,
      child: PageView.builder(
        controller: _mixesController,
        itemCount: mixes.length,
        padEnds: false,
        onPageChanged: (index) => setState(() => _currentMixIndex = index),
        itemBuilder: (context, index) => Padding(
          padding: .only(left: index == 0 ? 24 * scale : 8 * scale, right: 8 * scale),
          child: Align(
            alignment: .topLeft,
            child: AnimatedScale(
              scale: index == _currentMixIndex ? 1 : 0.92,
              duration: const Duration(milliseconds: 220),
              child: _buildMixCard(mixes[index], scale),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMixCard(DrinkModel drink, double scale) {
    const cardWidth = 248.0;
    const cardHeight = 334.0;
    final nameParts = drink.name.split(' ');
    final firstLine = nameParts.first;
    final secondLine = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return GestureDetector(
      onTap: () => context.push('${NamedRoutes.drinkDetail.routeName}/${drink.id}'),
      child: SizedBox(
        width: (cardWidth + 24) * scale,
        height: (cardHeight + 26) * scale,
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned(
              left: 46 * scale,
              top: 130 * scale,
              child: Container(
                width: (cardWidth - 88) * scale,
                height: (cardHeight - 88) * scale,
                decoration: BoxDecoration(color: AppColors.pinkLight, borderRadius: .circular(16 * scale)),
              ),
            ),
            Positioned(
              left: 23 * scale,
              top: 67 * scale,
              child: Container(
                width: (cardWidth - 44) * scale,
                height: (cardHeight - 45) * scale,
                decoration: BoxDecoration(color: AppColors.pinkMid, borderRadius: .circular(16 * scale)),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: cardWidth * scale,
                height: cardHeight * scale,
                decoration: BoxDecoration(color: AppColors.pink, borderRadius: .circular(16 * scale)),
                padding: .fromLTRB(12 * scale, 20 * scale, 12 * scale, 16 * scale),
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
                          spacing: 8 * scale,
                          children: [
                            SvgPicture.asset(AssetRes.icDrink, width: 28 * scale, height: 28 * scale),
                            Text(drink.category, style: AppTextStyles.mixCardCategory),
                          ],
                        ),
                        SizedBox(height: 8 * scale),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 4 * scale,
                                children: [
                                  SvgPicture.asset(AssetRes.icClock, width: 22 * scale, height: 22 * scale),
                                  Text('${drink.timeMinutes} ${StringConst.minSuffix}', style: AppTextStyles.mixCardMeta),
                                ],
                              ),
                            ),
                            Text(drink.difficulty, style: AppTextStyles.mixCardMeta),
                          ],
                        ),
                        SizedBox(height: 10 * scale),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 7 * scale,
                                children: [
                                  SvgPicture.asset(AssetRes.icHeart, width: 18 * scale, height: 16 * scale),
                                  Text('${drink.likes}', style: AppTextStyles.mixCardMeta),
                                ],
                              ),
                            ),
                            _buildRatingBadge(drink.rating, scale),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -15 * scale,
              top: -10 * scale,
              child: Image.asset(drink.heroImage, fit: .cover, height: 250 * scale),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating, double scale) {
    final filled = rating.round().clamp(0, 4);
    return Container(
      padding: .all(6 * scale),
      decoration: BoxDecoration(
        color: AppColors.starBadge,
        borderRadius: .circular(16 * scale),
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 2 * scale,
        children: List.generate(
          4,
          (index) => Opacity(
            opacity: index < filled ? 1 : 0.35,
            child: SvgPicture.asset(AssetRes.icStarFilled, width: 16 * scale, height: 16 * scale),
          ),
        ),
      ),
    );
  }
}

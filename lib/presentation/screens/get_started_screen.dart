import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:drinks_app/core/app_textstyles.dart';
import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        clipBehavior: .hardEdge,
        children: [
          Positioned(
            right: -20,
            top: -40,
            child: Image.asset(AssetRes.imgGetStartedMint, width: 180, fit: .contain),
          ),
          Positioned(
            left: -20,
            right: 0,
            bottom: -50,
            child: Image.asset(AssetRes.imgGetStartedSplash, fit: .contain, alignment: .bottomCenter),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(AssetRes.imgGetStartedKiwi, fit: .cover, alignment: .bottomCenter),
          ),
          Positioned(
            left: 37,
            bottom: 0,
            child: Image.asset(AssetRes.imgGetStartedCocktail, height: 532, fit: .contain),
          ),
          Padding(
            padding: .fromLTRB(24, 54, 24, 0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(StringConst.itsTimeForA, style: AppTextStyles.getStartedHeadline),
                Transform.translate(
                  offset: Offset(0, -8),
                  child: Text(StringConst.drink, style: AppTextStyles.freeStyleText),
                ),
                SizedBox(height: 12),
                Text(StringConst.getStartedSubtitle, style: AppTextStyles.subtitle),
                SizedBox(height: 24),
                _buildGetStartedButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: Container(
        padding: .symmetric(horizontal: 37, vertical: 17),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: .circular(40),
        ),
        child: Row(
          mainAxisSize: .min,
          spacing: 10,
          children: [
            Text(StringConst.getStarted, style: AppTextStyles.getStartedButton),
            SvgPicture.asset(AssetRes.icChevronRight, width: 4, height: 8),
          ],
        ),
      ),
    );
  }
}

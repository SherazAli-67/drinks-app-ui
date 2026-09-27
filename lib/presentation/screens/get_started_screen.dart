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

  static const _designWidth = 375.0;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.sizeOf(context).width / _designWidth;
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        clipBehavior: .hardEdge,
        children: [
          Positioned(
            right: -20 * scale,
            top: -40 * scale,
            child: Image.asset(AssetRes.imgGetStartedMint, width: 180 * scale, fit: .contain),
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
            left: 37 * scale,
            bottom: 0,
            child: Image.asset(AssetRes.imgGetStartedCocktail, height: 532 * scale, fit: .contain),
          ),

          Padding(
            padding: .fromLTRB(24 * scale, 54 * scale, 24 * scale, 0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(StringConst.itsTimeForA, style: AppTextStyles.getStartedHeadline),
                Transform.translate(
                  offset: Offset(0, -8 * scale),
                  child: Text(StringConst.drink, style: AppTextStyles.freeStyleText),
                ),
                SizedBox(height: 12 * scale),
                Text(StringConst.getStartedSubtitle, style: AppTextStyles.subtitle),
                SizedBox(height: 24 * scale),
                _buildGetStartedButton(context, scale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context, double scale) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: Container(
        padding: .symmetric(horizontal: 37 * scale, vertical: 17 * scale),
        decoration: BoxDecoration(
          color: AppColors.navy,
          borderRadius: .circular(40 * scale),
        ),
        child: Row(
          mainAxisSize: .min,
          spacing: 10 * scale,
          children: [
            Text(StringConst.getStarted, style: AppTextStyles.getStartedButton),
            SvgPicture.asset(AssetRes.icChevronRight, width: 4 * scale, height: 8 * scale),
          ],
        ),
      ),
    );
  }
}

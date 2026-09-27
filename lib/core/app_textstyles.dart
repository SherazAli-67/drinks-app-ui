import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // Poppins — headlines and primary CTA
  static TextStyle get getStartedHeadline => GoogleFonts.poppins(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        height: 44 / 34,
        color: AppColors.navy,
      );

  static TextStyle get getStartedButton => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      );

  static TextStyle get homePrompt => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 34 / 24,
        color: AppColors.navy,
      );

  // Freestyle Script — Get Started "Drink" only (bundled asset)
  static const TextStyle freeStyleText = TextStyle(
    fontSize: 70,
    fontFamily: StringConst.freeStyleFont,
    height: 1,
    color: AppColors.scriptPink,
  );

  // Raleway — body and UI chrome
  static TextStyle get subtitle => GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 24 / 16,
        color: AppColors.subtitle,
      );

  static TextStyle get sectionTitle => GoogleFonts.raleway(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 34 / 18,
        color: AppColors.navy,
      );

  static TextStyle get seeAll => GoogleFonts.raleway(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 34 / 12,
        color: AppColors.pink,
      );

  static TextStyle get categoryName => GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 34 / 14,
        color: AppColors.navy,
      );

  static TextStyle get categoryCount => GoogleFonts.raleway(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 34 / 11,
        color: AppColors.pink,
      );

  static TextStyle get searchHint => GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 34 / 14,
        color: AppColors.hint,
      );

  static TextStyle get mixCardCategory => GoogleFonts.raleway(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 34 / 20,
        color: AppColors.white,
      );

  static TextStyle get mixCardMeta => GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 34 / 16,
        color: AppColors.white,
      );

  static TextStyle get drinkTitle => GoogleFonts.raleway(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 44 / 26,
        color: AppColors.navy,
      );

  static TextStyle get drinkDescription => GoogleFonts.raleway(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        color: AppColors.subtitle,
      );

  static TextStyle get metaLabel => GoogleFonts.raleway(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 44 / 16,
      );

  static TextStyle get metaValue => GoogleFonts.raleway(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 44 / 32,
      );

  static TextStyle get metaServesValue => GoogleFonts.raleway(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 44 / 40,
        color: AppColors.pink,
      );

  static TextStyle get ingredientsHeader => GoogleFonts.raleway(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 44 / 24,
        color: AppColors.pink,
      );

  static TextStyle get ingredientQuantity => GoogleFonts.raleway(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 14 / 32,
        color: AppColors.pink,
      );

  static TextStyle get ingredientUnit => GoogleFonts.raleway(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 14 / 12,
        color: AppColors.pink,
      );

  static TextStyle get ingredientName => GoogleFonts.raleway(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 14 / 12,
        color: AppColors.navy,
      );

  // Anton — mix-card display names
  static TextStyle get mixCardTitle => GoogleFonts.anton(
        fontSize: 47,
        fontWeight: FontWeight.w400,
        height: 44 / 47,
        color: AppColors.white,
      );

  static TextStyle get mixCardTitleSecondary => GoogleFonts.anton(
        fontSize: 47,
        fontWeight: FontWeight.w400,
        height: 44 / 47,
        color: AppColors.whiteHalf,
      );

  static TextStyle get mixCardTitleSmall => GoogleFonts.anton(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 44 / 32,
        color: AppColors.white,
      );

  static TextStyle get mixCardTitleSmallSecondary => GoogleFonts.anton(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 44 / 32,
        color: AppColors.whiteHalf,
      );
}

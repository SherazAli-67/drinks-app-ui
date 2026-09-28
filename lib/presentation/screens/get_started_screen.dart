import 'package:drinks_app/constants/string_const.dart';
import 'package:drinks_app/core/app_colors.dart';
import 'package:drinks_app/core/app_textstyles.dart';
import 'package:drinks_app/core/asset_res.dart';
import 'package:drinks_app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _floatController;
  late final AnimationController _pressController;

  late final Animation<double> _cocktailOpacity;
  late final Animation<Offset> _cocktailSlide;
  late final Animation<double> _mintOpacity;
  late final Animation<Offset> _mintSlide;
  late final Animation<double> _mintFloat;
  late final Animation<double> _splashOpacity;
  late final Animation<double> _kiwiOpacity;
  late final Animation<double> _headlineOpacity;
  late final Animation<Offset> _headlineSlide;
  late final Animation<double> _drinkOpacity;
  late final Animation<Offset> _drinkSlide;
  late final Animation<double> _subtitleOpacity;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _buttonOpacity;
  late final Animation<Offset> _buttonSlide;
  late final Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _floatController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
    _pressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 120));

    _cocktailOpacity = _intervalOpacity(0.0, 0.55);
    _cocktailSlide = _intervalSlide(0.0, 0.55, beginOffset: const Offset(0, 0.12));
    _mintOpacity = _intervalOpacity(0.05, 0.5);
    _mintSlide = _intervalSlide(0.05, 0.5, beginOffset: const Offset(0.12, -0.08));
    _mintFloat = Tween(begin: -6.0, end: 6.0).animate(CurvedAnimation(parent: _floatController, curve: Curves.easeInOut));
    _splashOpacity = _intervalOpacity(0.15, 0.6);
    _kiwiOpacity = _intervalOpacity(0.2, 0.65);
    _headlineOpacity = _intervalOpacity(0.25, 0.7);
    _headlineSlide = _intervalSlide(0.25, 0.7);
    _drinkOpacity = _intervalOpacity(0.35, 0.75);
    _drinkSlide = _intervalSlide(0.35, 0.75);
    _subtitleOpacity = _intervalOpacity(0.45, 0.85);
    _subtitleSlide = _intervalSlide(0.45, 0.85);
    _buttonOpacity = _intervalOpacity(0.55, 0.95);
    _buttonSlide = _intervalSlide(0.55, 0.95);
    _buttonScale = Tween(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeOut));

    _entranceController.forward();
  }

  Animation<double> _intervalOpacity(double begin, double end) {
    return CurvedAnimation(parent: _entranceController, curve: Interval(begin, end, curve: Curves.easeOutCubic));
  }

  Animation<Offset> _intervalSlide(double begin, double end, {Offset beginOffset = const Offset(0, 0.08)}) {
    return Tween(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: Interval(begin, end, curve: Curves.easeOutCubic)),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: AnimatedBuilder(
        animation: Listenable.merge([_entranceController, _floatController, _pressController]),
        builder: (context, _) => Stack(
          clipBehavior: .hardEdge,
          children: [
            Positioned(
              right: -20,
              top: -40 + _mintFloat.value,
              child: FadeTransition(
                opacity: _mintOpacity,
                child: SlideTransition(
                  position: _mintSlide,
                  child: Image.asset(AssetRes.imgGetStartedMint, width: 180, fit: .contain),
                ),
              ),
            ),
            Positioned(
              left: -20,
              right: 0,
              bottom: -50,
              child: FadeTransition(
                opacity: _splashOpacity,
                child: Image.asset(AssetRes.imgGetStartedSplash, fit: .contain, alignment: .bottomCenter),
              ),
            ),
            Positioned(
              bottom: 0,
              child: FadeTransition(
                opacity: _kiwiOpacity,
                child: Image.asset(AssetRes.imgGetStartedKiwi, fit: .cover, alignment: .bottomCenter),
              ),
            ),
            Positioned(
              left: 37,
              bottom: 0,
              child: FadeTransition(
                opacity: _cocktailOpacity,
                child: SlideTransition(
                  position: _cocktailSlide,
                  child: Image.asset(AssetRes.imgGetStartedCocktail,fit: .cover),
                ),
              ),
            ),
            Padding(
              padding: .fromLTRB(24, 54, 24, 0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  FadeTransition(
                    opacity: _headlineOpacity,
                    child: SlideTransition(
                      position: _headlineSlide,
                      child: Text(StringConst.itsTimeForA, style: AppTextStyles.getStartedHeadline),
                    ),
                  ),
                  FadeTransition(
                    opacity: _drinkOpacity,
                    child: SlideTransition(
                      position: _drinkSlide,
                      child: Transform.translate(
                        offset: Offset(0, -8),
                        child: Text(StringConst.drink, style: AppTextStyles.freeStyleText),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  FadeTransition(
                    opacity: _subtitleOpacity,
                    child: SlideTransition(
                      position: _subtitleSlide,
                      child: Text(StringConst.getStartedSubtitle, style: AppTextStyles.subtitle),
                    ),
                  ),
                  SizedBox(height: 24),
                  FadeTransition(
                    opacity: _buttonOpacity,
                    child: SlideTransition(
                      position: _buttonSlide,
                      child: _buildGetStartedButton(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapCancel: () => _pressController.reverse(),
      onTapUp: (_) async {
        await _pressController.reverse();
        if (!context.mounted) return;
        context.go(NamedRoutes.home.routeName);
      },
      child: ScaleTransition(
        scale: _buttonScale,
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
      ),
    );
  }
}

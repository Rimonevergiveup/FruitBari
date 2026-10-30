import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum LogoVariant {
  full,
  symbol,
  compact,
  wordmark,
  monochrome,
}

class FruitBariLogo extends StatelessWidget {
  final LogoVariant variant;
  final double? width;
  final double? height;
  final bool showTagline;
  final Color? monochromeColor;

  const FruitBariLogo({
    super.key,
    this.variant = LogoVariant.compact,
    this.width,
    this.height,
    this.showTagline = false,
    this.monochromeColor,
  });

  const FruitBariLogo.full({
    super.key,
    this.width = 220,
    this.height,
    this.showTagline = true,
    this.monochromeColor,
  }) : variant = LogoVariant.full;

  const FruitBariLogo.symbol({
    super.key,
    this.width = 40,
    this.height = 40,
    this.monochromeColor,
  })  : variant = LogoVariant.symbol,
        showTagline = false;

  const FruitBariLogo.compact({
    super.key,
    this.height = 36,
    this.width,
    this.monochromeColor,
  })  : variant = LogoVariant.compact,
        showTagline = false;

  const FruitBariLogo.monochrome({
    super.key,
    this.width = 160,
    this.height,
    this.monochromeColor = AppColors.primaryDark,
  })  : variant = LogoVariant.monochrome,
        showTagline = false;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case LogoVariant.symbol:
        return Image.asset(
          'assets/branding/logo_symbol.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Container(
            width: width ?? 40,
            height: height ?? 40,
            decoration: const BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_rounded, color: AppColors.primary, size: 24),
          ),
        );

      case LogoVariant.full:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/branding/logo_full.png',
              width: width,
              height: height,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_basket_rounded, color: AppColors.primary, size: 64),
                  const SizedBox(height: 8),
                  _twoToneWordmark(fontSize: 26),
                ],
              ),
            ),
          ],
        );

      case LogoVariant.compact:
        // Compact layout for AppBars: symbol + two-tone "FruitBari" wordmark
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/branding/logo_symbol.png',
              height: height ?? 36,
              width: height ?? 36,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.eco_rounded,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 8),
            _twoToneWordmark(fontSize: (height != null ? height! * 0.58 : 20)),
          ],
        );

      case LogoVariant.wordmark:
        return Image.asset(
          'assets/branding/logo_wordmark.png',
          width: width,
          height: height,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _twoToneWordmark(fontSize: 22),
        );

      case LogoVariant.monochrome:
        return Image.asset(
          'assets/branding/logo_monochrome.png',
          width: width,
          height: height,
          color: monochromeColor ?? AppColors.primaryDark,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(
            Icons.eco_rounded,
            color: monochromeColor ?? AppColors.primaryDark,
            size: width ?? 48,
          ),
        );
    }
  }

  Widget _twoToneWordmark({required double fontSize}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
        children: const [
          TextSpan(
            text: 'Fruit',
            style: TextStyle(color: AppColors.primary),
          ),
          TextSpan(
            text: 'Bari',
            style: TextStyle(color: AppColors.brandOrange),
          ),
        ],
      ),
    );
  }
}

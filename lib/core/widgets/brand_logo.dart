import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Kirya wordmark used in the navbar, footer and admin shell.
///
/// Uses a typographic mark so the project renders without a binary asset; swap
/// the leading mark for an `Image.asset(logoUrl)` once a logo file is added.
class BrandLogo extends StatelessWidget {
  const BrandLogo({
    super.key,
    this.onDark = false,
    this.size = 22,
    this.brandName = 'Kirya',
  });

  final bool onDark;
  final double size;
  final String brandName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size + 12,
          width: size + 12,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular((size + 12) / 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.luxuryGold.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'K',
            style: TextStyle(
              color: AppColors.deepBlack,
              fontWeight: FontWeight.w800,
              fontSize: size,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          brandName,
          style: TextStyle(
            color: onDark ? Colors.white : AppColors.textDark,
            fontWeight: FontWeight.w700,
            fontSize: size,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

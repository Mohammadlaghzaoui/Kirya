import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Eyebrow + title + optional subtitle, centered, used to introduce sections.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
    this.onDark = false,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final center = alignment == CrossAxisAlignment.center;
    final titleColor = onDark ? Colors.white : AppColors.textDark;
    final subColor = onDark ? Colors.white70 : AppColors.textMuted;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.luxuryGold.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            eyebrow.toUpperCase(),
            style: const TextStyle(
              color: AppColors.darkGold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(
            title,
            textAlign: center ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              subtitle!,
              textAlign: center ? TextAlign.center : TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: subColor),
            ),
          ),
        ],
      ],
    );
  }
}

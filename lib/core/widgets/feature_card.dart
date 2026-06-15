import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_card.dart';

/// Icon + title (+ optional description) tile used in feature grids.
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.style = CardStyle.light,
    this.accent = AppColors.tealGreen,
  });

  final IconData icon;
  final String title;
  final String? description;
  final CardStyle style;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final onDark = style != CardStyle.light;
    return AppCard(
      style: style,
      hoverable: true,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: onDark ? 0.18 : 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: onDark ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: onDark ? Colors.white70 : AppColors.textMuted,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

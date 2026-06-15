import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_card.dart';

/// KPI tile used in the admin dashboard and the hero dashboard mock.
class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.style = CardStyle.light,
    this.accent = AppColors.tealGreen,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? trend;
  final bool trendPositive;
  final CardStyle style;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final onDark = style != CardStyle.light;
    return AppCard(
      style: style,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: onDark ? 0.20 : 0.12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon, color: accent, size: 18),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: onDark ? Colors.white60 : AppColors.textMuted,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: onDark ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w700,
                ),
          ),
          if (trend != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  trendPositive
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 15,
                  color: trendPositive ? AppColors.tealGreen : AppColors.danger,
                ),
                const SizedBox(width: 5),
                Text(
                  trend!,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color:
                        trendPositive ? AppColors.tealGreen : AppColors.danger,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

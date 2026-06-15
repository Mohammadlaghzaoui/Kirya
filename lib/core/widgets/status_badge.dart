import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum BadgeTone { success, warning, danger, neutral, info, gold }

/// Small pill used for statuses (active, pending, recommended, etc.).
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = BadgeTone.neutral,
    this.icon,
  });

  final String label;
  final BadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = switch (tone) {
      BadgeTone.success => (AppColors.deepTeal, AppColors.softMint.withValues(alpha: 0.45)),
      BadgeTone.warning => (const Color(0xFF8A5A1F), const Color(0xFFF7E6CC)),
      BadgeTone.danger => (const Color(0xFF8A2F26), const Color(0xFFF6D9D5)),
      BadgeTone.info => (AppColors.deepTeal, AppColors.tealGreen.withValues(alpha: 0.16)),
      BadgeTone.gold => (AppColors.darkGold, AppColors.softGold.withValues(alpha: 0.5)),
      BadgeTone.neutral => (AppColors.textMuted, AppColors.lightGrey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: fg),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

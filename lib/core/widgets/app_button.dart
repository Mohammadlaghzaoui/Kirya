import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum AppButtonVariant { primary, secondary, outline, ghost, gold }

/// Brand button with consistent sizing, variants and an optional loading state.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.expand = false,
    this.dense = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final bool expand;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final colors = _resolve();
    final padding = EdgeInsets.symmetric(
      horizontal: dense ? 18 : 26,
      vertical: dense ? 12 : 17,
    );

    final child = loading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              valueColor: AlwaysStoppedAnimation(colors.foreground),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: colors.foreground),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colors.foreground,
                        fontWeight: FontWeight.w600,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );

    final button = Material(
      color: colors.background,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        onTap: loading ? null : onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: colors.gradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: colors.border != null
                ? Border.all(color: colors.border!, width: 1.4)
                : null,
          ),
          child: Padding(padding: padding, child: Center(child: child)),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  _ButtonColors _resolve() {
    switch (variant) {
      case AppButtonVariant.primary:
        return const _ButtonColors(
          background: AppColors.tealGreen,
          foreground: Colors.white,
        );
      case AppButtonVariant.secondary:
        return const _ButtonColors(
          background: AppColors.deepBlack,
          foreground: Colors.white,
        );
      case AppButtonVariant.gold:
        return const _ButtonColors(
          background: AppColors.luxuryGold,
          foreground: AppColors.deepBlack,
          gradient: AppColors.goldGradient,
        );
      case AppButtonVariant.outline:
        return const _ButtonColors(
          background: Colors.transparent,
          foreground: AppColors.deepBlack,
          border: AppColors.deepBlack,
        );
      case AppButtonVariant.ghost:
        return _ButtonColors(
          background: AppColors.tealGreen.withValues(alpha: 0.10),
          foreground: AppColors.deepTeal,
        );
    }
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    this.border,
    this.gradient,
  });
  final Color background;
  final Color foreground;
  final Color? border;
  final Gradient? gradient;
}

import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

enum CardStyle { light, dark, glass }

/// Rounded brand card with optional glassmorphism and hover elevation.
class AppCard extends StatefulWidget {
  const AppCard({
    super.key,
    required this.child,
    this.style = CardStyle.light,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = AppTheme.radiusLg,
    this.hoverable = false,
    this.border,
    this.onTap,
  });

  final Widget child;
  final CardStyle style;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool hoverable;
  final Border? border;
  final VoidCallback? onTap;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius);
    final isDark = widget.style == CardStyle.dark;
    final isGlass = widget.style == CardStyle.glass;

    final baseColor = switch (widget.style) {
      CardStyle.light => AppColors.surface,
      CardStyle.dark => AppColors.charcoalBlack,
      CardStyle.glass => Colors.white.withValues(alpha: 0.08),
    };

    final shadow = [
      BoxShadow(
        color: Colors.black
            .withValues(alpha: _hover && widget.hoverable ? 0.16 : 0.06),
        blurRadius: _hover && widget.hoverable ? 36 : 22,
        offset: Offset(0, _hover && widget.hoverable ? 16 : 10),
      ),
    ];

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: _hover && widget.hoverable
          ? (Matrix4.identity()..translate(0.0, -6.0))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: radius,
        border: widget.border ??
            (isGlass
                ? Border.all(color: Colors.white.withValues(alpha: 0.14))
                : isDark
                    ? Border.all(color: Colors.white.withValues(alpha: 0.06))
                    : Border.all(color: AppColors.lightGrey)),
        boxShadow: shadow,
      ),
      padding: widget.padding,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: isDark || isGlass ? Colors.white : AppColors.textDark,
        ),
        child: widget.child,
      ),
    );

    if (isGlass) {
      content = ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: content,
        ),
      );
    }

    if (widget.onTap != null || widget.hoverable) {
      content = MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        child: GestureDetector(onTap: widget.onTap, child: content),
      );
    }

    return content;
  }
}

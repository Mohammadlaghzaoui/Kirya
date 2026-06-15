import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../../models/package_model.dart';
import '../localization/app_localizations.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';
import 'app_card.dart';
import 'status_badge.dart';

/// Pricing card for a B2B package, with feature list and subscribe CTA.
/// Highlighted (recommended) cards use the dark luxury treatment.
class PricingCard extends StatelessWidget {
  const PricingCard({
    super.key,
    required this.package,
    required this.cycle,
    required this.onSubscribe,
    this.loading = false,
  });

  final PackageModel package;
  final BillingCycle cycle;
  final VoidCallback onSubscribe;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final highlighted = package.recommended;
    final onDark = highlighted;
    final price = package.priceFor(cycle);
    final period =
        cycle == BillingCycle.monthly ? l.t('packages.perMonth') : l.t('packages.perYear');

    final textColor = onDark ? Colors.white : AppColors.textDark;
    final mutedColor = onDark ? Colors.white70 : AppColors.textMuted;

    return AppCard(
      style: highlighted ? CardStyle.dark : CardStyle.light,
      hoverable: true,
      padding: const EdgeInsets.all(28),
      border: highlighted
          ? Border.all(color: AppColors.luxuryGold.withValues(alpha: 0.5), width: 1.4)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  package.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              if (highlighted)
                StatusBadge(
                  label: l.t('packages.recommended'),
                  tone: BadgeTone.gold,
                  icon: Icons.star_rounded,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            package.description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: mutedColor, height: 1.5),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${package.currency}${price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  period,
                  style: TextStyle(color: mutedColor, fontSize: 15),
                ),
              ),
            ],
          ),
          if (cycle == BillingCycle.yearly)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: StatusBadge(
                label: l.t('packages.saveYearly'),
                tone: BadgeTone.success,
              ),
            ),
          if (package.setupFee > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '+ ${package.currency}${package.setupFee.toStringAsFixed(0)} ${l.t('packages.setupFee').toLowerCase()}',
                style: TextStyle(color: mutedColor, fontSize: 13),
              ),
            ),
          const SizedBox(height: 22),
          AppButton(
            label: l.t('packages.subscribe'),
            variant: highlighted
                ? AppButtonVariant.gold
                : AppButtonVariant.primary,
            expand: true,
            loading: loading,
            icon: Icons.lock_outline_rounded,
            onPressed: onSubscribe,
          ),
          const SizedBox(height: 24),
          if (package.inheritsFromName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                l.t('packages.everythingIn',
                    params: {'plan': package.inheritsFromName!}),
                style: TextStyle(
                  color: onDark ? AppColors.softGold : AppColors.darkGold,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                l.t('packages.included'),
                style: TextStyle(
                  color: mutedColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ),
          ...package.features.map(
            (f) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: highlighted ? AppColors.softMint : AppColors.tealGreen,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      f,
                      style: TextStyle(color: textColor, height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

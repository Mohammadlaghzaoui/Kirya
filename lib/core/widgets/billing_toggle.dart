import 'package:flutter/material.dart';

import '../../models/enums.dart';
import '../localization/app_localizations.dart';
import '../theme/app_colors.dart';

/// Segmented monthly / yearly toggle for pricing.
class BillingToggle extends StatelessWidget {
  const BillingToggle({
    super.key,
    required this.cycle,
    required this.onChanged,
  });

  final BillingCycle cycle;
  final ValueChanged<BillingCycle> onChanged;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segment(context, l.t('packages.monthly'), BillingCycle.monthly),
          _segment(context, l.t('packages.yearly'), BillingCycle.yearly),
        ],
      ),
    );
  }

  Widget _segment(BuildContext context, String label, BillingCycle value) {
    final selected = cycle == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.deepBlack : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textMuted,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

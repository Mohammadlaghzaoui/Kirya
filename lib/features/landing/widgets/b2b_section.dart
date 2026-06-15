import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/feature_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';

class B2bSection extends StatelessWidget {
  const B2bSection({super.key});

  static const _features = <(IconData, String)>[
    (Icons.directions_car_filled_rounded, 'feature.fleet'),
    (Icons.event_available_rounded, 'feature.availability'),
    (Icons.calendar_month_rounded, 'feature.bookings'),
    (Icons.sync_alt_rounded, 'feature.rentalFlow'),
    (Icons.people_alt_rounded, 'feature.customers'),
    (Icons.description_rounded, 'feature.contracts'),
    (Icons.car_crash_rounded, 'feature.damage'),
    (Icons.account_balance_wallet_rounded, 'feature.payments'),
    (Icons.receipt_long_rounded, 'feature.invoices'),
    (Icons.folder_rounded, 'feature.documents'),
    (Icons.badge_rounded, 'feature.staff'),
    (Icons.insights_rounded, 'feature.reports'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final columns = Responsive.value<int>(context, mobile: 1, tablet: 2, desktop: 3);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        child: Column(
          children: [
            SectionHeader(
              eyebrow: l.t('b2b.eyebrow'),
              title: l.t('b2b.title'),
              subtitle: l.t('b2b.subtitle'),
            ),
            const SizedBox(height: 44),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 18.0;
                final itemWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final f in _features)
                      SizedBox(
                        width: itemWidth,
                        child: FeatureCard(icon: f.$1, title: l.t(f.$2)),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 36),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.charcoalBlack,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lock_rounded,
                      color: AppColors.luxuryGold, size: 22),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l.t('b2b.note'),
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.55,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

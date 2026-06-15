import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/status_badge.dart';

class B2cSection extends StatelessWidget {
  const B2cSection({super.key});

  static const _benefits = <(IconData, String)>[
    (Icons.person_add_alt_rounded, 'b2c.account'),
    (Icons.search_rounded, 'b2c.search'),
    (Icons.price_check_rounded, 'b2c.prices'),
    (Icons.shield_rounded, 'b2c.securePay'),
    (Icons.verified_rounded, 'b2c.verified'),
    (Icons.confirmation_number_rounded, 'b2c.confirmation'),
    (Icons.article_rounded, 'b2c.conditions'),
    (Icons.thumb_up_rounded, 'b2c.reliable'),
    (Icons.history_rounded, 'b2c.history'),
    (Icons.headset_mic_rounded, 'b2c.support'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isDesktop = Responsive.isDesktop(context);

    final info = Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        SectionHeader(
          eyebrow: l.t('b2c.eyebrow'),
          title: l.t('b2c.title'),
          subtitle: l.t('b2c.subtitle'),
          alignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          onDark: true,
        ),
        const SizedBox(height: 20),
        StatusBadge(
          label: l.t('b2c.free'),
          tone: BadgeTone.success,
          icon: Icons.check_circle_rounded,
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment:
              isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            AppButton(
              label: l.t('b2c.ctaCreate'),
              variant: AppButtonVariant.gold,
              icon: Icons.person_add_alt_1_rounded,
              onPressed: () => context.go(Routes.customers),
            ),
            AppButton(
              label: l.t('b2c.ctaDiscover'),
              variant: AppButtonVariant.ghost,
              icon: Icons.smartphone_rounded,
              onPressed: () => context.go(Routes.customers),
            ),
          ],
        ),
      ],
    );

    final benefitGrid = Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final b in _benefits)
          Container(
            width: isDesktop ? 240 : double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Row(
              children: [
                Icon(b.$1, color: AppColors.softMint, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l.t(b.$2),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.darkGradient),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        child: Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 5 : 0, child: info),
            SizedBox(width: isDesktop ? 48 : 0, height: isDesktop ? 0 : 40),
            Expanded(flex: isDesktop ? 6 : 0, child: benefitGrid),
          ],
        ),
      ),
    );
  }
}

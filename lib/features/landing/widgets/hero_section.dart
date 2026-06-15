import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/dashboard_stat_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/status_badge.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isDesktop = Responsive.isDesktop(context);

    final textColumn = Column(
      crossAxisAlignment:
          isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        StatusBadge(
          label: l.t('hero.badge'),
          tone: BadgeTone.gold,
          icon: Icons.directions_car_filled_rounded,
        ),
        const SizedBox(height: 22),
        Text(
          l.t('hero.title'),
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.08,
                fontSize: isDesktop ? 52 : 36,
              ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            l.t('hero.subtitle'),
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 17,
                ),
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment:
              isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            AppButton(
              label: l.t('hero.ctaPrimary'),
              icon: Icons.business_center_rounded,
              onPressed: () => context.go(Routes.companies),
            ),
            AppButton(
              label: l.t('hero.ctaSecondary'),
              variant: AppButtonVariant.outline,
              icon: Icons.local_offer_outlined,
              onPressed: () => context.go(Routes.packages),
            ),
          ],
        ),
        const SizedBox(height: 26),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.softMint.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                  color: AppColors.tealGreen.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person_outline_rounded,
                    color: AppColors.deepTeal, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l.t('hero.b2cMessage'),
                    style: const TextStyle(
                      color: AppColors.deepTeal,
                      height: 1.5,
                      fontSize: 14.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 80 : 48),
      child: ContentContainer(
        child: Column(
          children: [
            Flex(
              direction: isDesktop ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: isDesktop ? 5 : 0, child: textColumn),
                SizedBox(width: isDesktop ? 48 : 0, height: isDesktop ? 0 : 48),
                Expanded(
                  flex: isDesktop ? 5 : 0,
                  child: const _DashboardVisual(),
                ),
              ],
            ),
            const SizedBox(height: 56),
            const _TrustBadges(),
          ],
        ),
      ),
    );
  }
}

/// Modern dashboard visual placeholder shown beside the hero copy.
class _DashboardVisual extends StatelessWidget {
  const _DashboardVisual();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AppCard(
      style: CardStyle.dark,
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.dashboard_rounded,
                    color: AppColors.deepBlack, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                l.t('dashboard.title'),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const StatusBadge(label: 'Live', tone: BadgeTone.success),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DashboardStatCard(
                  label: l.t('dashboard.activeVehicles'),
                  value: '142',
                  icon: Icons.directions_car_rounded,
                  trend: '+8%',
                  style: CardStyle.glass,
                  accent: AppColors.softMint,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: DashboardStatCard(
                  label: l.t('dashboard.bookings'),
                  value: '87',
                  icon: Icons.event_available_rounded,
                  trend: '+12%',
                  style: CardStyle.glass,
                  accent: AppColors.luxuryGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: DashboardStatCard(
                  label: l.t('dashboard.revenue'),
                  value: '€38.4k',
                  icon: Icons.payments_rounded,
                  trend: '+5%',
                  style: CardStyle.glass,
                  accent: AppColors.softMint,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: DashboardStatCard(
                  label: l.t('dashboard.utilization'),
                  value: '78%',
                  icon: Icons.speed_rounded,
                  trend: '+3%',
                  style: CardStyle.glass,
                  accent: AppColors.luxuryGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const _MiniChart(),
        ],
      ),
    );
  }
}

class _MiniChart extends StatelessWidget {
  const _MiniChart();

  @override
  Widget build(BuildContext context) {
    const bars = [0.4, 0.65, 0.5, 0.8, 0.6, 0.9, 0.75];
    return Container(
      height: 92,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < bars.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  height: 60 * bars[i],
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: i.isEven
                          ? [AppColors.tealGreen, AppColors.softMint]
                          : [AppColors.darkGold, AppColors.softGold],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final badges = [
      (Icons.verified_user_outlined, l.t('trust.securePayment')),
      (Icons.workspace_premium_outlined, l.t('trust.verifiedCompanies')),
      (Icons.devices_outlined, l.t('trust.digitalManagement')),
      (Icons.support_agent_outlined, l.t('trust.proSupport')),
    ];
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        for (final b in badges)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.lightGrey),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(b.$1, size: 18, color: AppColors.deepTeal),
                const SizedBox(width: 10),
                Text(
                  b.$2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

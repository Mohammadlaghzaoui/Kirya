import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/brand_logo.dart';
import '../../../core/widgets/responsive.dart';
import '../../../providers/auth_provider.dart';

/// Placeholder for the protected rental management portal (a separate app in
/// production). Access is gated by [hasPortalAccessProvider] in the router.
class PortalPage extends ConsumerWidget {
  const PortalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final user = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      body: Center(
        child: ContentContainer(
          maxWidth: 560,
          child: AppCard(
            style: CardStyle.dark,
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandLogo(onDark: true, size: 26),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.tealGreen.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.dashboard_customize_rounded,
                      color: AppColors.softMint, size: 34),
                ),
                const SizedBox(height: 24),
                Text(
                  l.t('portal.welcome'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                if (user != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    user.displayName,
                    style: const TextStyle(color: AppColors.luxuryGold),
                  ),
                ],
                const SizedBox(height: 14),
                Text(
                  l.t('portal.placeholder'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, height: 1.6),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      label: l.t('auth.logout'),
                      variant: AppButtonVariant.ghost,
                      dense: true,
                      onPressed: () {
                        ref.read(authProvider.notifier).signOut();
                        context.go(Routes.home);
                      },
                    ),
                    const SizedBox(width: 12),
                    AppButton(
                      label: l.t('common.backHome'),
                      variant: AppButtonVariant.gold,
                      dense: true,
                      onPressed: () => context.go(Routes.home),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

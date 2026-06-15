import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/brand_logo.dart';
import '../../../core/widgets/responsive.dart';

class CheckoutCancelPage extends StatelessWidget {
  const CheckoutCancelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.deepBlack,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: AppCard(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandLogo(size: 24),
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close_rounded,
                        color: AppColors.warning, size: 40),
                  ),
                  const SizedBox(height: 24),
                  Text(l.t('checkout.cancelTitle'),
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 12),
                  Text(
                    l.t('checkout.cancelMessage'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 28),
                  AppButton(
                    label: l.t('checkout.retry'),
                    expand: true,
                    icon: Icons.refresh_rounded,
                    onPressed: () => context.go(Routes.packages),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: l.t('checkout.backHome'),
                    variant: AppButtonVariant.ghost,
                    expand: true,
                    onPressed: () => context.go(Routes.home),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/services/navigation_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/brand_logo.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/responsive.dart';
import '../../../models/enums.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';

/// Stripe success redirect target. Activates the company subscription (mirroring
/// the webhook) then confirms portal access.
class CheckoutSuccessPage extends ConsumerStatefulWidget {
  const CheckoutSuccessPage({super.key, this.packageId, this.cycle, this.company, this.email});

  final String? packageId;
  final String? cycle;
  final String? company;
  final String? email;

  @override
  ConsumerState<CheckoutSuccessPage> createState() =>
      _CheckoutSuccessPageState();
}

class _CheckoutSuccessPageState extends ConsumerState<CheckoutSuccessPage> {
  bool _activating = true;
  String? _reference;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _activate());
  }

  Future<void> _activate() async {
    final packageId = widget.packageId;
    if (packageId == null) {
      setState(() => _activating = false);
      return;
    }
    final pkg = await ref.read(packageRepositoryProvider).byId(packageId);
    if (pkg == null) {
      if (mounted) setState(() => _activating = false);
      return;
    }
    final cycle = BillingCycle.fromName(widget.cycle ?? 'monthly');
    final result =
        await ref.read(billingRepositoryProvider).activateAfterPayment(
              packageId: pkg.id,
              packageName: pkg.name,
              billingCycle: cycle,
              amount: pkg.priceFor(cycle),
              companyName: widget.company ?? 'New Rental Company',
              contactEmail: widget.email ?? 'new-company@example.com',
              stripeCustomerId: 'cus_${DateTime.now().millisecondsSinceEpoch}',
              stripeSubscriptionId:
                  'sub_${DateTime.now().millisecondsSinceEpoch}',
            );
    bumpRevision(ref);
    if (mounted) {
      setState(() {
        _activating = false;
        _reference = result.subscription.id;
      });
    }
  }

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
              child: _activating
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: LoadingState(),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BrandLogo(size: 24),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: AppColors.tealGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded,
                              color: Colors.white, size: 40),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l.t('checkout.successTitle'),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l.t('checkout.successMessage'),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: AppColors.textMuted),
                        ),
                        if (_reference != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            '${l.t('checkout.reference')}: $_reference',
                            style: const TextStyle(
                                color: AppColors.darkGold,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ],
                        const SizedBox(height: 28),
                        AppButton(
                          label: l.t('checkout.successCta'),
                          variant: AppButtonVariant.gold,
                          icon: Icons.login_rounded,
                          expand: true,
                          onPressed: () {
                            // Redirect to the (placeholder) portal URL.
                            if (AppConstants.portalUrl.startsWith('/')) {
                              context.go(Routes.portal);
                            } else {
                              const NavigationService()
                                  .openExternal(AppConstants.portalUrl);
                            }
                          },
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

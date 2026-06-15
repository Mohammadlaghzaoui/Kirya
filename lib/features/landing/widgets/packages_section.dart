import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/billing_toggle.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/pricing_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/enums.dart';
import '../../../models/package_model.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';

class PackagesSection extends ConsumerStatefulWidget {
  const PackagesSection({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  ConsumerState<PackagesSection> createState() => _PackagesSectionState();
}

class _PackagesSectionState extends ConsumerState<PackagesSection> {
  BillingCycle _cycle = BillingCycle.monthly;
  String? _loadingPackageId;

  Future<void> _subscribe(PackageModel package) async {
    setState(() => _loadingPackageId = package.id);
    try {
      final session = await ref.read(stripeServiceProvider).createCheckoutSession(
            package: package,
            cycle: _cycle,
          );
      if (!mounted) return;
      // Demo: route straight to the in-app success page. Production: redirect to
      // session.stripeCheckoutUrl via NavigationService.openExternal.
      context.go(session.redirectPath);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).t('contact.error'))),
      );
    } finally {
      if (mounted) setState(() => _loadingPackageId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final packagesAsync = ref.watch(activePackagesProvider);
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        child: Column(
          children: [
            if (widget.showHeader)
              SectionHeader(
                eyebrow: l.t('packages.eyebrow'),
                title: l.t('packages.title'),
                subtitle: l.t('packages.subtitle'),
              ),
            const SizedBox(height: 28),
            BillingToggle(
              cycle: _cycle,
              onChanged: (c) => setState(() => _cycle = c),
            ),
            const SizedBox(height: 40),
            packagesAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(40),
                child: LoadingState(),
              ),
              error: (e, _) => EmptyState(message: l.t('common.empty')),
              data: (packages) {
                if (packages.isEmpty) {
                  return EmptyState(message: l.t('common.empty'));
                }
                final cards = packages
                    .map((p) => PricingCard(
                          package: p,
                          cycle: _cycle,
                          loading: _loadingPackageId == p.id,
                          onSubscribe: () => _subscribe(p),
                        ))
                    .toList();

                if (isDesktop) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < cards.length; i++) ...[
                        if (i > 0) const SizedBox(width: 24),
                        Expanded(child: cards[i]),
                      ],
                    ],
                  );
                }
                return Column(
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      if (i > 0) const SizedBox(height: 24),
                      cards[i],
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

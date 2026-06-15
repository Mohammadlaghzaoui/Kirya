import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/dashboard_stat_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../models/enums.dart';
import '../../../providers/content_providers.dart';
import '../widgets/admin_scaffold.dart';

class AdminDashboardPage extends ConsumerWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final payments = ref.watch(paymentsProvider);
    final companies = ref.watch(companiesProvider);
    final contacts = ref.watch(contactRequestsProvider);

    final totalRevenue = payments.maybeWhen(
      data: (list) => list
          .where((p) => p.paymentStatus == PaymentStatus.succeeded)
          .fold<double>(0, (sum, p) => sum + p.amount),
      orElse: () => 0.0,
    );
    final activeSubs = payments.maybeWhen(
      data: (list) => list
          .where((p) => p.subscriptionStatus == SubscriptionStatus.active)
          .length,
      orElse: () => 0,
    );
    final companyCount =
        companies.maybeWhen(data: (l) => l.length, orElse: () => 0);
    final newContacts = contacts.maybeWhen(
      data: (l) => l.where((c) => !c.handled).length,
      orElse: () => 0,
    );

    final columns = Responsive.value<int>(context, mobile: 1, tablet: 2, desktop: 4);

    return AdminScaffold(
      title: l.t('admin.dashboard'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.t('admin.overview'),
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 18),
          LayoutBuilder(builder: (context, constraints) {
            const gap = 16.0;
            final w = (constraints.maxWidth - gap * (columns - 1)) / columns;
            final cards = [
              DashboardStatCard(
                label: l.t('admin.totalRevenue'),
                value: '€${totalRevenue.toStringAsFixed(0)}',
                icon: Icons.payments_rounded,
                trend: '+14%',
                accent: AppColors.tealGreen,
              ),
              DashboardStatCard(
                label: l.t('admin.activeSubs'),
                value: '$activeSubs',
                icon: Icons.verified_rounded,
                trend: '+3',
                accent: AppColors.luxuryGold,
              ),
              DashboardStatCard(
                label: l.t('admin.companiesCount'),
                value: '$companyCount',
                icon: Icons.apartment_rounded,
                accent: AppColors.deepTeal,
              ),
              DashboardStatCard(
                label: l.t('admin.newContacts'),
                value: '$newContacts',
                icon: Icons.mark_email_unread_rounded,
                accent: AppColors.darkGold,
              ),
            ];
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final c in cards) SizedBox(width: w, child: c),
              ],
            );
          }),
          const SizedBox(height: 28),
          Flex(
            direction:
                Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: Responsive.isDesktop(context) ? 1 : 0,
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.t('admin.recentPayments'),
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      payments.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (_, __) => EmptyState(message: l.t('common.empty')),
                        data: (list) => list.isEmpty
                            ? EmptyState(message: l.t('common.empty'))
                            : Column(
                                children: [
                                  for (final p in list.take(5))
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(p.companyName),
                                      subtitle: Text(p.packageName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      trailing: Text(
                                        '€${p.amount.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: Responsive.isDesktop(context) ? 24 : 0,
                  height: Responsive.isDesktop(context) ? 0 : 24),
              Expanded(
                flex: Responsive.isDesktop(context) ? 1 : 0,
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.t('admin.recentContacts'),
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      contacts.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (_, __) => EmptyState(message: l.t('common.empty')),
                        data: (list) => list.isEmpty
                            ? EmptyState(message: l.t('common.empty'))
                            : Column(
                                children: [
                                  for (final c in list.take(5))
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(c.companyName),
                                      subtitle: Text(c.contactPerson),
                                      trailing: StatusBadge(
                                        label: c.handled
                                            ? l.t('common.active')
                                            : l.t('admin.newContacts'),
                                        tone: c.handled
                                            ? BadgeTone.success
                                            : BadgeTone.warning,
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../models/enums.dart';
import '../../../models/payment.dart';
import '../../../providers/content_providers.dart';
import '../widgets/admin_scaffold.dart';

class PaymentsPage extends ConsumerWidget {
  const PaymentsPage({super.key});

  String _date(DateTime? d) =>
      d == null ? '—' : '${d.day}/${d.month}/${d.year}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final payments = ref.watch(paymentsProvider);

    return AdminScaffold(
      title: l.t('admin.payments'),
      child: payments.when(
        loading: () =>
            const Padding(padding: EdgeInsets.all(40), child: LoadingState()),
        error: (_, __) => EmptyState(message: l.t('common.empty')),
        data: (list) {
          if (list.isEmpty) return EmptyState(message: l.t('common.empty'));
          return AppCard(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.textDark),
                columns: [
                  DataColumn(label: Text(l.t('contact.company'))),
                  DataColumn(label: Text(l.t('admin.packages'))),
                  const DataColumn(label: Text('Amount')),
                  DataColumn(label: Text(l.t('packages.monthly'))),
                  const DataColumn(label: Text('Payment')),
                  const DataColumn(label: Text('Subscription')),
                  const DataColumn(label: Text('Stripe customer')),
                  const DataColumn(label: Text('Stripe sub')),
                  const DataColumn(label: Text('Created')),
                  const DataColumn(label: Text('Last payment')),
                ],
                rows: [
                  for (final p in list) _row(context, p),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  DataRow _row(BuildContext context, Payment p) {
    return DataRow(cells: [
      DataCell(Text(p.companyName)),
      DataCell(ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Text(p.packageName, overflow: TextOverflow.ellipsis),
      )),
      DataCell(Text('${p.currency}${p.amount.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.w700))),
      DataCell(Text(p.billingCycle == BillingCycle.monthly
          ? AppLocalizations.of(context).t('packages.monthly')
          : AppLocalizations.of(context).t('packages.yearly'))),
      DataCell(StatusBadge(
        label: p.paymentStatus.name,
        tone: p.paymentStatus == PaymentStatus.succeeded
            ? BadgeTone.success
            : p.paymentStatus == PaymentStatus.failed
                ? BadgeTone.danger
                : BadgeTone.warning,
      )),
      DataCell(StatusBadge(
        label: p.subscriptionStatus.name,
        tone: p.subscriptionStatus == SubscriptionStatus.active
            ? BadgeTone.success
            : BadgeTone.neutral,
      )),
      DataCell(Text(p.stripeCustomerId ?? '—',
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
      DataCell(Text(p.stripeSubscriptionId ?? '—',
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12))),
      DataCell(Text(_date(p.createdAt))),
      DataCell(Text(_date(p.lastPaymentAt))),
    ]);
  }
}

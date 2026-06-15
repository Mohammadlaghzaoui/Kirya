import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../providers/content_providers.dart';
import '../widgets/admin_scaffold.dart';

class AdminCompaniesPage extends ConsumerWidget {
  const AdminCompaniesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final companies = ref.watch(companiesProvider);

    return AdminScaffold(
      title: l.t('admin.companies'),
      child: companies.when(
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
                  DataColumn(label: Text(l.t('contact.email'))),
                  DataColumn(label: Text(l.t('contact.phone'))),
                  DataColumn(label: Text(l.t('contact.vehicles'))),
                  const DataColumn(label: Text('Portal access')),
                  DataColumn(label: Text(l.t('common.status'))),
                ],
                rows: [
                  for (final c in list)
                    DataRow(cells: [
                      DataCell(Text(c.name,
                          style:
                              const TextStyle(fontWeight: FontWeight.w600))),
                      DataCell(Text(c.contactEmail)),
                      DataCell(Text(c.contactPhone ?? '—')),
                      DataCell(Text('${c.vehicleCount ?? '—'}')),
                      DataCell(StatusBadge(
                        label: c.portalAccess
                            ? l.t('common.yes')
                            : l.t('common.no'),
                        tone: c.portalAccess
                            ? BadgeTone.success
                            : BadgeTone.neutral,
                      )),
                      DataCell(StatusBadge(
                        label: c.status.name,
                        tone: BadgeTone.info,
                      )),
                    ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

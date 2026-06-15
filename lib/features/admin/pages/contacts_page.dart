import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';
import '../widgets/admin_scaffold.dart';

class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final contacts = ref.watch(contactRequestsProvider);

    return AdminScaffold(
      title: l.t('admin.contacts'),
      child: contacts.when(
        loading: () =>
            const Padding(padding: EdgeInsets.all(40), child: LoadingState()),
        error: (_, __) => EmptyState(message: l.t('common.empty')),
        data: (list) {
          if (list.isEmpty) return EmptyState(message: l.t('common.empty'));
          return Column(
            children: [
              for (final c in list)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                c.companyName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            StatusBadge(
                              label: c.handled
                                  ? l.t('common.active')
                                  : l.t('admin.newContacts'),
                              tone: c.handled
                                  ? BadgeTone.success
                                  : BadgeTone.warning,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 22,
                          runSpacing: 8,
                          children: [
                            _info(Icons.person_outline, c.contactPerson),
                            _info(Icons.email_outlined, c.email),
                            if (c.phone != null)
                              _info(Icons.phone_outlined, c.phone!),
                            if (c.vehicleCount != null)
                              _info(Icons.directions_car_outlined,
                                  '${c.vehicleCount} ${l.t('contact.vehicles').toLowerCase()}'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(c.message,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: AppColors.textMuted)),
                        const Divider(height: 28),
                        Row(
                          children: [
                            TextButton.icon(
                              onPressed: () async {
                                await ref
                                    .read(contactRepositoryProvider)
                                    .markHandled(c.id, handled: !c.handled);
                                bumpRevision(ref);
                              },
                              icon: Icon(c.handled
                                  ? Icons.undo_rounded
                                  : Icons.check_circle_outline_rounded),
                              label: Text(c.handled
                                  ? l.t('common.inactive')
                                  : l.t('common.confirm')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.deepTeal),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 13.5)),
      ],
    );
  }
}

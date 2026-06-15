import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/confirmation_dialog.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../models/enums.dart';
import '../../../models/package_model.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';
import '../widgets/admin_scaffold.dart';
import '../widgets/package_editor.dart';

class PackageManagementPage extends ConsumerWidget {
  const PackageManagementPage({super.key});

  Future<void> _edit(BuildContext context, WidgetRef ref, PackageModel pkg,
      {bool isNew = false}) async {
    final result =
        await PackageEditor.show(context, package: pkg, isNew: isNew);
    if (result == null) return;
    final repo = ref.read(packageRepositoryProvider);
    if (isNew) {
      await repo.create(result);
    } else {
      await repo.update(result);
    }
    bumpRevision(ref);
  }

  Future<void> _delete(
      BuildContext context, WidgetRef ref, PackageModel pkg) async {
    final l = AppLocalizations.of(context);
    final ok = await ConfirmationDialog.show(
      context,
      title: l.t('common.delete'),
      message: '${l.t('common.delete')} "${pkg.name}"?',
      destructive: true,
    );
    if (!ok) return;
    await ref.read(packageRepositoryProvider).delete(pkg.id);
    bumpRevision(ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final packages = ref.watch(allPackagesProvider);

    return AdminScaffold(
      title: l.t('admin.packages'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l.t('admin.packages'),
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              AppButton(
                label: l.t('common.create'),
                icon: Icons.add_rounded,
                dense: true,
                onPressed: () {
                  final now = DateTime.now();
                  _edit(
                    context,
                    ref,
                    PackageModel(
                      id: ref.read(packageRepositoryProvider).newId(),
                      name: '',
                      description: '',
                      features: const [],
                      monthlyPrice: 0,
                      yearlyPrice: 0,
                      order: 99,
                      createdAt: now,
                      updatedAt: now,
                    ),
                    isNew: true,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          packages.when(
            loading: () => const Padding(
                padding: EdgeInsets.all(40), child: LoadingState()),
            error: (_, __) => EmptyState(message: l.t('common.empty')),
            data: (list) {
              if (list.isEmpty) return EmptyState(message: l.t('common.empty'));
              return Column(
                children: [
                  for (final pkg in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _PackageRow(
                        package: pkg,
                        onEdit: () => _edit(context, ref, pkg),
                        onDelete: () => _delete(context, ref, pkg),
                        onToggle: () async {
                          await ref
                              .read(packageRepositoryProvider)
                              .toggleActive(pkg.id);
                          bumpRevision(ref);
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PackageRow extends StatelessWidget {
  const _PackageRow({
    required this.package,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  final PackageModel package;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              Text(
                package.name.isEmpty ? '—' : package.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (package.recommended)
                StatusBadge(
                    label: l.t('packages.recommended'),
                    tone: BadgeTone.gold,
                    icon: Icons.star_rounded),
              StatusBadge(
                label: package.isActive
                    ? l.t('common.active')
                    : l.t('common.inactive'),
                tone: package.isActive ? BadgeTone.success : BadgeTone.neutral,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            package.description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 20,
            runSpacing: 8,
            children: [
              _meta(context, l.t('packages.monthly'),
                  '€${package.monthlyPrice.toStringAsFixed(0)}'),
              _meta(context, l.t('packages.yearly'),
                  '€${package.yearlyPrice.toStringAsFixed(0)}'),
              if (package.setupFee > 0)
                _meta(context, l.t('packages.setupFee'),
                    '€${package.setupFee.toStringAsFixed(0)}'),
              _meta(context, 'Stripe',
                  package.stripePriceIdMonthly == null ? '—' : '✓'),
              _meta(context, 'Order', '${package.order}'),
            ],
          ),
          const Divider(height: 28),
          Row(
            children: [
              TextButton.icon(
                onPressed: onToggle,
                icon: Icon(
                  package.isActive
                      ? Icons.toggle_on_rounded
                      : Icons.toggle_off_rounded,
                  color: package.isActive
                      ? AppColors.tealGreen
                      : AppColors.textMuted,
                ),
                label: Text(package.isActive
                    ? l.t('common.active')
                    : l.t('common.inactive')),
              ),
              const Spacer(),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_rounded, color: AppColors.deepTeal),
                tooltip: l.t('common.edit'),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.danger),
                tooltip: l.t('common.delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _meta(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ],
    );
  }
}

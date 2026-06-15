import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../providers/cms_provider.dart';
import '../widgets/admin_scaffold.dart';

class CmsSettingsPage extends ConsumerWidget {
  const CmsSettingsPage({super.key});

  static const _labels = {
    HomeSection.hero: 'Hero',
    HomeSection.b2b: 'B2B information',
    HomeSection.b2c: 'B2C information',
    HomeSection.packages: 'Packages',
    HomeSection.howItWorks: 'How it works',
    HomeSection.faq: 'FAQ',
    HomeSection.contact: 'Contact',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final sections = ref.watch(cmsSectionsProvider);

    return AdminScaffold(
      title: l.t('admin.cms'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.visibility_rounded,
                        color: AppColors.deepTeal, size: 20),
                    const SizedBox(width: 10),
                    Text('Homepage sections',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Toggle which sections appear on the public homepage.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 12),
                for (final section in HomeSection.values)
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.tealGreen,
                    title: Text(_labels[section] ?? section.name),
                    value: sections[section] ?? true,
                    onChanged: (v) => ref
                        .read(cmsSectionsProvider.notifier)
                        .toggle(section, v),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppCard(
            style: CardStyle.dark,
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded,
                    color: AppColors.luxuryGold),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Brand, hero, content, contact details and social links are '
                    'managed in Website Settings. Packages are managed in '
                    'Package Management. Translations are managed in the '
                    'Translations screen.',
                    style: const TextStyle(color: Colors.white70, height: 1.55),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

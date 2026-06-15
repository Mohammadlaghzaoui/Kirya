import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/faq_section.dart';
import '../widgets/packages_section.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('packages.eyebrow'),
          title: l.t('packages.title'),
          subtitle: l.t('packages.subtitle'),
        ),
        const PackagesSection(showHeader: false),
        const FaqSection(),
      ],
    );
  }
}

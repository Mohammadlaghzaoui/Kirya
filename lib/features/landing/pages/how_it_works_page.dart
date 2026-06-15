import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/packages_section.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('how.eyebrow'),
          title: l.t('how.title'),
        ),
        const HowItWorksSection(),
        const PackagesSection(),
      ],
    );
  }
}

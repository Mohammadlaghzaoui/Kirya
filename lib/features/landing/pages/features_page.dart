import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/b2b_section.dart';
import '../widgets/b2c_section.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('nav.features'),
          title: l.t('b2b.title'),
          subtitle: l.t('b2b.subtitle'),
        ),
        const B2bSection(),
        const B2cSection(),
      ],
    );
  }
}

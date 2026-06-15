import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/b2c_section.dart';
import '../widgets/faq_section.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('b2c.eyebrow'),
          title: l.t('b2c.title'),
          subtitle: l.t('b2c.subtitle'),
        ),
        const B2cSection(),
        const FaqSection(),
      ],
    );
  }
}

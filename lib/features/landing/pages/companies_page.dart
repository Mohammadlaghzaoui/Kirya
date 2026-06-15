import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/b2b_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/packages_section.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('b2b.eyebrow'),
          title: l.t('b2b.title'),
          subtitle: l.t('b2b.subtitle'),
        ),
        const B2bSection(),
        const HowItWorksSection(),
        const PackagesSection(),
        const ContactSection(),
      ],
    );
  }
}

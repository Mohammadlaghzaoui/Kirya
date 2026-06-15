import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/page_hero.dart';
import '../../../core/widgets/public_scaffold.dart';
import '../widgets/contact_section.dart';
import '../widgets/faq_section.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PublicScaffold(
      children: [
        PageHero(
          eyebrow: l.t('faq.eyebrow'),
          title: l.t('faq.title'),
        ),
        const FaqSection(),
        const ContactSection(),
      ],
    );
  }
}

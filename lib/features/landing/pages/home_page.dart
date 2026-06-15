import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/public_scaffold.dart';
import '../../../providers/cms_provider.dart';
import '../widgets/b2b_section.dart';
import '../widgets/b2c_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/faq_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/how_it_works_section.dart';
import '../widgets/packages_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(cmsSectionsProvider);
    bool visible(HomeSection s) => sections[s] ?? true;

    return PublicScaffold(
      children: [
        if (visible(HomeSection.hero)) const HeroSection(),
        if (visible(HomeSection.b2b)) const B2bSection(),
        if (visible(HomeSection.b2c)) const B2cSection(),
        if (visible(HomeSection.packages)) const PackagesSection(),
        if (visible(HomeSection.howItWorks)) const HowItWorksSection(),
        if (visible(HomeSection.faq)) const FaqSection(),
        if (visible(HomeSection.contact)) const ContactSection(),
      ],
    );
  }
}

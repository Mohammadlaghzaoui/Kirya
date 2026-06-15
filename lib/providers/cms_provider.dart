import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Homepage section identifiers managed from the CMS settings screen.
enum HomeSection { hero, b2b, b2c, packages, howItWorks, faq, contact }

/// Visibility flags for homepage sections. Defaults to all visible.
class CmsSectionsNotifier extends Notifier<Map<HomeSection, bool>> {
  @override
  Map<HomeSection, bool> build() =>
      {for (final s in HomeSection.values) s: true};

  void toggle(HomeSection section, bool value) {
    state = {...state, section: value};
  }
}

final cmsSectionsProvider =
    NotifierProvider<CmsSectionsNotifier, Map<HomeSection, bool>>(
        CmsSectionsNotifier.new);

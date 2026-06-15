import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_localizations.dart';

/// Holds the active locale. Defaults to French as required by the brief.
class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() => const Locale('fr');

  void setLocale(Locale locale) {
    if (AppLocalizations.supportedLocales
        .any((l) => l.languageCode == locale.languageCode)) {
      state = locale;
    }
  }

  void setLanguageCode(String code) => setLocale(Locale(code));
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);

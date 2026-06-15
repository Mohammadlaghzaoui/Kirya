import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// JSON-backed localization.
///
/// Translations live in `assets/i18n/<code>.json` as flat key/value maps so the
/// admin "Language / Translation Management" screen can edit them without code
/// changes. Lookups fall back to French (the default locale) when a key is
/// missing in the active language, and finally to the key itself.
class AppLocalizations {
  AppLocalizations(this.locale, this._values);

  final Locale locale;
  final Map<String, String> _values;

  static Map<String, String> _fallback = const {};

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Supported locales. French is first → used as the default.
  static const List<Locale> supportedLocales = [
    Locale('fr'),
    Locale('nl'),
    Locale('en'),
    Locale('de'),
    Locale('it'),
    Locale('ar'),
  ];

  static const Map<String, String> languageNames = {
    'fr': 'Français',
    'nl': 'Nederlands',
    'en': 'English',
    'de': 'Deutsch',
    'it': 'Italiano',
    'ar': 'العربية',
  };

  static const Map<String, String> languageFlags = {
    'fr': '🇫🇷',
    'nl': '🇳🇱',
    'en': '🇬🇧',
    'de': '🇩🇪',
    'it': '🇮🇹',
    'ar': '🇸🇦',
  };

  static bool isRtl(Locale locale) => locale.languageCode == 'ar';

  /// Resolve a translation key. Supports simple `{name}` placeholder
  /// interpolation via [params].
  String t(String key, {Map<String, String>? params}) {
    var value = _values[key] ?? _fallback[key] ?? key;
    if (params != null) {
      params.forEach((k, v) => value = value.replaceAll('{$k}', v));
    }
    return value;
  }

  String operator [](String key) => t(key);

  static Future<Map<String, String>> _load(String code) async {
    try {
      final raw = await rootBundle.loadString('assets/i18n/$code.json');
      final decoded = json.decode(raw) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, v.toString()));
    } catch (e) {
      debugPrint('AppLocalizations: failed to load "$code": $e');
      return {};
    }
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Ensure the French fallback is available for missing keys.
    if (AppLocalizations._fallback.isEmpty) {
      AppLocalizations._fallback = await AppLocalizations._load('fr');
    }
    final values = locale.languageCode == 'fr'
        ? AppLocalizations._fallback
        : await AppLocalizations._load(locale.languageCode);
    return AppLocalizations(locale, values);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

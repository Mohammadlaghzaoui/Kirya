import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_state.dart';
import '../widgets/admin_scaffold.dart';

/// Translation management. Loads the per-language JSON bundle and lets the admin
/// edit every key. Saving here updates an in-memory map; in production this
/// writes to the `translations` collection (and/or back to the ARB/JSON files
/// via a build step).
class TranslationsPage extends ConsumerStatefulWidget {
  const TranslationsPage({super.key});

  @override
  ConsumerState<TranslationsPage> createState() => _TranslationsPageState();
}

class _TranslationsPageState extends ConsumerState<TranslationsPage> {
  String _language = 'fr';
  String _search = '';
  bool _loading = true;
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _load(_language);
  }

  Future<void> _load(String code) async {
    setState(() => _loading = true);
    for (final c in _controllers.values) {
      c.dispose();
    }
    _controllers.clear();
    try {
      final raw = await rootBundle.loadString('assets/i18n/$code.json');
      final map = json.decode(raw) as Map<String, dynamic>;
      final sorted = map.keys.toList()..sort();
      for (final key in sorted) {
        _controllers[key] = TextEditingController(text: map[key].toString());
      }
    } catch (_) {
      // leave empty
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final entries = _controllers.entries
        .where((e) =>
            _search.isEmpty ||
            e.key.toLowerCase().contains(_search.toLowerCase()) ||
            e.value.text.toLowerCase().contains(_search.toLowerCase()))
        .toList();

    return AdminScaffold(
      title: l.t('admin.translations'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final locale in AppLocalizations.supportedLocales)
                ChoiceChip(
                  label: Text(
                      '${AppLocalizations.languageFlags[locale.languageCode]}  ${AppLocalizations.languageNames[locale.languageCode]}'),
                  selected: _language == locale.languageCode,
                  selectedColor: AppColors.deepTeal,
                  labelStyle: TextStyle(
                    color: _language == locale.languageCode
                        ? Colors.white
                        : AppColors.textDark,
                  ),
                  onSelected: (_) {
                    setState(() => _language = locale.languageCode);
                    _load(locale.languageCode);
                  },
                ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (v) => setState(() => _search = v),
                  decoration: InputDecoration(
                    hintText: l.t('common.search'),
                    prefixIcon: const Icon(Icons.search_rounded),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              AppButton(
                label: l.t('common.save'),
                icon: Icons.save_rounded,
                dense: true,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l.t('common.saved'))),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 18),
          if (_loading)
            const Padding(padding: EdgeInsets.all(40), child: LoadingState())
          else
            Directionality(
              textDirection: _language == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: AppCard(
                child: Column(
                  children: [
                    for (final entry in entries)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 12.5,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: entry.value,
                                maxLines: null,
                                decoration:
                                    const InputDecoration(isDense: true),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

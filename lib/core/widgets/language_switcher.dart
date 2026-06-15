import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../localization/app_localizations.dart';
import '../localization/locale_provider.dart';
import '../theme/app_colors.dart';

/// Dropdown to switch between the six supported languages. Updating the locale
/// also flips the layout direction for Arabic (RTL).
class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key, this.onDark = false, this.compact = false});

  final bool onDark;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final fg = onDark ? Colors.white : AppColors.textDark;

    return PopupMenuButton<String>(
      tooltip: 'Language',
      offset: const Offset(0, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      onSelected: (code) =>
          ref.read(localeProvider.notifier).setLanguageCode(code),
      itemBuilder: (context) => AppLocalizations.supportedLocales.map((l) {
        final code = l.languageCode;
        final selected = code == locale.languageCode;
        return PopupMenuItem<String>(
          value: code,
          child: Row(
            children: [
              Text(AppLocalizations.languageFlags[code] ?? '',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.languageNames[code] ?? code,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected ? AppColors.deepTeal : AppColors.textDark,
                ),
              ),
              if (selected) ...[
                const Spacer(),
                const Icon(Icons.check_rounded,
                    size: 16, color: AppColors.tealGreen),
              ],
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 10 : 14,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: onDark
              ? Colors.white.withValues(alpha: 0.08)
              : AppColors.lightGrey.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: onDark
                ? Colors.white.withValues(alpha: 0.16)
                : AppColors.lightGrey,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.languageFlags[locale.languageCode] ?? '🌐',
              style: const TextStyle(fontSize: 16),
            ),
            if (!compact) ...[
              const SizedBox(width: 8),
              Text(
                locale.languageCode.toUpperCase(),
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(width: 4),
            Icon(Icons.expand_more_rounded, size: 18, color: fg),
          ],
        ),
      ),
    );
  }
}

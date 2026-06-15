import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_state.dart';
import '../../../models/website_settings.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';
import '../widgets/admin_scaffold.dart';
import '../widgets/cms_field_editor.dart';

class WebsiteSettingsPage extends ConsumerStatefulWidget {
  const WebsiteSettingsPage({super.key});

  @override
  ConsumerState<WebsiteSettingsPage> createState() =>
      _WebsiteSettingsPageState();
}

class _WebsiteSettingsPageState extends ConsumerState<WebsiteSettingsPage> {
  final _c = <String, TextEditingController>{};
  bool _initialized = false;
  bool _saving = false;

  TextEditingController _ctrl(String key, String value) =>
      _c.putIfAbsent(key, () => TextEditingController(text: value));

  void _init(WebsiteSettings s) {
    if (_initialized) return;
    _ctrl('brandName', s.brandName);
    _ctrl('logoUrl', s.logoUrl);
    _ctrl('primary', s.primaryColorHex);
    _ctrl('secondary', s.secondaryColorHex);
    _ctrl('accent', s.accentColorHex);
    _ctrl('heroTitle', s.heroTitle);
    _ctrl('heroSubtitle', s.heroSubtitle);
    _ctrl('ctaPrimary', s.ctaPrimaryText);
    _ctrl('ctaSecondary', s.ctaSecondaryText);
    _ctrl('b2b', s.b2bContent);
    _ctrl('b2c', s.b2cContent);
    _ctrl('footer', s.footerContent);
    _ctrl('email', s.contactEmail);
    _ctrl('phone', s.contactPhone);
    _ctrl('address', s.contactAddress);
    _ctrl('linkedin', s.linkedinUrl);
    _ctrl('instagram', s.instagramUrl);
    _ctrl('facebook', s.facebookUrl);
    _ctrl('x', s.xUrl);
    _initialized = true;
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save(WebsiteSettings current) async {
    setState(() => _saving = true);
    final updated = current.copyWith(
      brandName: _c['brandName']!.text,
      logoUrl: _c['logoUrl']!.text,
      primaryColorHex: _c['primary']!.text,
      secondaryColorHex: _c['secondary']!.text,
      accentColorHex: _c['accent']!.text,
      heroTitle: _c['heroTitle']!.text,
      heroSubtitle: _c['heroSubtitle']!.text,
      ctaPrimaryText: _c['ctaPrimary']!.text,
      ctaSecondaryText: _c['ctaSecondary']!.text,
      b2bContent: _c['b2b']!.text,
      b2cContent: _c['b2c']!.text,
      footerContent: _c['footer']!.text,
      contactEmail: _c['email']!.text,
      contactPhone: _c['phone']!.text,
      contactAddress: _c['address']!.text,
      linkedinUrl: _c['linkedin']!.text,
      instagramUrl: _c['instagram']!.text,
      facebookUrl: _c['facebook']!.text,
      xUrl: _c['x']!.text,
    );
    await ref.read(settingsRepositoryProvider).save(updated);
    bumpRevision(ref);
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).t('common.saved'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final settingsAsync = ref.watch(websiteSettingsProvider);

    return AdminScaffold(
      title: l.t('admin.settings'),
      child: settingsAsync.when(
        loading: () => const Padding(
            padding: EdgeInsets.all(40), child: LoadingState()),
        error: (e, _) => Text('$e'),
        data: (settings) {
          _init(settings);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(context, 'Brand', Icons.workspace_premium_rounded, [
                CMSFieldRow(children: [
                  CMSFieldEditor(label: 'Brand name', controller: _c['brandName']!),
                  CMSFieldEditor(label: 'Logo URL', controller: _c['logoUrl']!),
                ]),
                _ColorRow(
                  primary: _c['primary']!,
                  secondary: _c['secondary']!,
                  accent: _c['accent']!,
                ),
              ]),
              _section(context, l.t('hero.badge'), Icons.title_rounded, [
                CMSFieldEditor(
                    label: 'Hero title (override)',
                    controller: _c['heroTitle']!,
                    hint: l.t('hero.title'),
                    maxLines: 2),
                CMSFieldEditor(
                    label: 'Hero subtitle (override)',
                    controller: _c['heroSubtitle']!,
                    hint: l.t('hero.subtitle'),
                    maxLines: 2),
                CMSFieldRow(children: [
                  CMSFieldEditor(
                      label: 'Primary CTA', controller: _c['ctaPrimary']!,
                      hint: l.t('hero.ctaPrimary')),
                  CMSFieldEditor(
                      label: 'Secondary CTA', controller: _c['ctaSecondary']!,
                      hint: l.t('hero.ctaSecondary')),
                ]),
              ]),
              _section(context, 'Content', Icons.article_rounded, [
                CMSFieldEditor(
                    label: 'B2B content', controller: _c['b2b']!, maxLines: 3),
                CMSFieldEditor(
                    label: 'B2C content', controller: _c['b2c']!, maxLines: 3),
                CMSFieldEditor(
                    label: l.t('footer.tagline'),
                    controller: _c['footer']!,
                    maxLines: 2),
              ]),
              _section(context, l.t('contact.eyebrow'), Icons.contact_mail_rounded, [
                CMSFieldRow(children: [
                  CMSFieldEditor(
                      label: l.t('contact.email'), controller: _c['email']!),
                  CMSFieldEditor(
                      label: l.t('contact.phone'), controller: _c['phone']!),
                ]),
                CMSFieldEditor(label: 'Address', controller: _c['address']!),
              ]),
              _section(context, l.t('footer.followUs'), Icons.share_rounded, [
                CMSFieldRow(children: [
                  CMSFieldEditor(label: 'LinkedIn', controller: _c['linkedin']!),
                  CMSFieldEditor(label: 'Instagram', controller: _c['instagram']!),
                ]),
                CMSFieldRow(children: [
                  CMSFieldEditor(label: 'Facebook', controller: _c['facebook']!),
                  CMSFieldEditor(label: 'X / Twitter', controller: _c['x']!),
                ]),
              ]),
              const SizedBox(height: 8),
              AppButton(
                label: l.t('common.save'),
                icon: Icons.save_rounded,
                loading: _saving,
                onPressed: () => _save(settings),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _section(
      BuildContext context, String title, IconData icon, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.deepTeal, size: 20),
                const SizedBox(width: 10),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 18),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.primary,
    required this.secondary,
    required this.accent,
  });

  final TextEditingController primary;
  final TextEditingController secondary;
  final TextEditingController accent;

  Color _parse(String hex) {
    final cleaned = hex.replaceAll('#', '').trim();
    final value = int.tryParse('FF$cleaned', radix: 16);
    return value == null ? AppColors.textMuted : Color(value);
  }

  @override
  Widget build(BuildContext context) {
    Widget swatch(TextEditingController c, String label) {
      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: c,
              decoration: InputDecoration(
                prefixText: '#',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: AnimatedBuilder(
                    animation: c,
                    builder: (_, __) => Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _parse(c.text),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.lightGrey),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    final isWide = MediaQuery.sizeOf(context).width > 720;
    final children = [
      swatch(primary, 'Primary'),
      if (isWide) const SizedBox(width: 16),
      swatch(secondary, 'Secondary'),
      if (isWide) const SizedBox(width: 16),
      swatch(accent, 'Accent'),
    ];
    return isWide
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: children)
        : Column(children: children);
  }
}

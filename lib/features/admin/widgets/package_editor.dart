import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_button.dart';
import '../../../models/enums.dart';
import '../../../models/package_model.dart';
import 'cms_field_editor.dart';

/// Full editor for a B2B package (create or edit). Returns the edited
/// [PackageModel] via [Navigator.pop].
class PackageEditor extends StatefulWidget {
  const PackageEditor({super.key, required this.package, this.isNew = false});

  final PackageModel package;
  final bool isNew;

  static Future<PackageModel?> show(
    BuildContext context, {
    required PackageModel package,
    bool isNew = false,
  }) {
    return showDialog<PackageModel>(
      context: context,
      builder: (_) => PackageEditor(package: package, isNew: isNew),
    );
  }

  @override
  State<PackageEditor> createState() => _PackageEditorState();
}

class _PackageEditorState extends State<PackageEditor> {
  late final TextEditingController _name;
  late final TextEditingController _description;
  late final TextEditingController _monthly;
  late final TextEditingController _yearly;
  late final TextEditingController _setupFee;
  late final TextEditingController _order;
  late final TextEditingController _stripeMonthly;
  late final TextEditingController _stripeYearly;
  late final TextEditingController _inherits;
  late List<TextEditingController> _features;
  late bool _recommended;
  late bool _active;

  @override
  void initState() {
    super.initState();
    final p = widget.package;
    _name = TextEditingController(text: p.name);
    _description = TextEditingController(text: p.description);
    _monthly = TextEditingController(text: p.monthlyPrice.toStringAsFixed(0));
    _yearly = TextEditingController(text: p.yearlyPrice.toStringAsFixed(0));
    _setupFee = TextEditingController(text: p.setupFee.toStringAsFixed(0));
    _order = TextEditingController(text: p.order.toString());
    _stripeMonthly = TextEditingController(text: p.stripePriceIdMonthly ?? '');
    _stripeYearly = TextEditingController(text: p.stripePriceIdYearly ?? '');
    _inherits = TextEditingController(text: p.inheritsFromName ?? '');
    _features =
        p.features.map((f) => TextEditingController(text: f)).toList();
    if (_features.isEmpty) _features.add(TextEditingController());
    _recommended = p.recommended;
    _active = p.isActive;
  }

  @override
  void dispose() {
    for (final c in [
      _name,
      _description,
      _monthly,
      _yearly,
      _setupFee,
      _order,
      _stripeMonthly,
      _stripeYearly,
      _inherits,
      ..._features,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    final features = _features
        .map((c) => c.text.trim())
        .where((t) => t.isNotEmpty)
        .toList();
    final result = widget.package.copyWith(
      name: _name.text.trim(),
      description: _description.text.trim(),
      features: features,
      monthlyPrice: double.tryParse(_monthly.text.trim()) ?? 0,
      yearlyPrice: double.tryParse(_yearly.text.trim()) ?? 0,
      setupFee: double.tryParse(_setupFee.text.trim()) ?? 0,
      order: int.tryParse(_order.text.trim()) ?? widget.package.order,
      recommended: _recommended,
      status: _active ? RecordStatus.active : RecordStatus.inactive,
      stripePriceIdMonthly:
          _stripeMonthly.text.trim().isEmpty ? null : _stripeMonthly.text.trim(),
      stripePriceIdYearly:
          _stripeYearly.text.trim().isEmpty ? null : _stripeYearly.text.trim(),
      inheritsFromName:
          _inherits.text.trim().isEmpty ? null : _inherits.text.trim(),
    );
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 24, 28, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.isNew ? l.t('common.create') : l.t('common.edit'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CMSFieldEditor(label: l.t('contact.company'), controller: _name),
                    CMSFieldEditor(
                        label: l.t('packages.included'),
                        controller: _description,
                        maxLines: 2),
                    CMSFieldRow(children: [
                      CMSFieldEditor(
                        label: l.t('packages.monthly'),
                        controller: _monthly,
                        keyboardType: TextInputType.number,
                        prefix: const Icon(Icons.euro_rounded, size: 18),
                      ),
                      CMSFieldEditor(
                        label: l.t('packages.yearly'),
                        controller: _yearly,
                        keyboardType: TextInputType.number,
                        prefix: const Icon(Icons.euro_rounded, size: 18),
                      ),
                    ]),
                    CMSFieldRow(children: [
                      CMSFieldEditor(
                        label: l.t('packages.setupFee'),
                        controller: _setupFee,
                        keyboardType: TextInputType.number,
                        prefix: const Icon(Icons.euro_rounded, size: 18),
                      ),
                      CMSFieldEditor(
                        label: 'Order',
                        controller: _order,
                        keyboardType: TextInputType.number,
                      ),
                    ]),
                    CMSFieldEditor(
                      label: 'Inherits from (optional)',
                      controller: _inherits,
                      hint: 'e.g. Rental Management',
                    ),
                    CMSFieldRow(children: [
                      CMSFieldEditor(
                        label: 'Stripe price ID (monthly)',
                        controller: _stripeMonthly,
                        hint: 'price_...',
                      ),
                      CMSFieldEditor(
                        label: 'Stripe price ID (yearly)',
                        controller: _stripeYearly,
                        hint: 'price_...',
                      ),
                    ]),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _recommended,
                            activeColor: AppColors.tealGreen,
                            title: Text(l.t('packages.recommended')),
                            onChanged: (v) => setState(() => _recommended = v),
                          ),
                        ),
                        Expanded(
                          child: SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _active,
                            activeColor: AppColors.tealGreen,
                            title: Text(l.t('common.active')),
                            onChanged: (v) => setState(() => _active = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Features',
                            style: Theme.of(context).textTheme.titleSmall),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => setState(
                              () => _features.add(TextEditingController())),
                          icon: const Icon(Icons.add_rounded, size: 18),
                          label: Text(l.t('common.add')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (var i = 0; i < _features.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _features[i],
                                decoration: InputDecoration(
                                  hintText: 'Feature ${i + 1}',
                                  isDense: true,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _features.removeAt(i)),
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: AppColors.danger, size: 20),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    label: l.t('common.cancel'),
                    variant: AppButtonVariant.ghost,
                    dense: true,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 12),
                  AppButton(
                    label: l.t('common.save'),
                    dense: true,
                    icon: Icons.check_rounded,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

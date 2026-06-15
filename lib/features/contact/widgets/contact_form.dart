import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../providers/content_providers.dart';
import '../../../providers/repository_providers.dart';

/// "Request a demonstration" form. Stores leads via [ContactRepository].
class ContactForm extends ConsumerStatefulWidget {
  const ContactForm({super.key});

  @override
  ConsumerState<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends ConsumerState<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _company = TextEditingController();
  final _person = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _vehicles = TextEditingController();
  final _message = TextEditingController();
  bool _submitting = false;
  bool _done = false;

  @override
  void dispose() {
    for (final c in [_company, _person, _email, _phone, _vehicles, _message]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      await ref.read(contactRepositoryProvider).submit(
            companyName: _company.text.trim(),
            contactPerson: _person.text.trim(),
            email: _email.text.trim(),
            phone: _phone.text.trim().isEmpty ? null : _phone.text.trim(),
            vehicleCount: int.tryParse(_vehicles.text.trim()),
            message: _message.text.trim(),
          );
      bumpRevision(ref);
      if (!mounted) return;
      setState(() => _done = true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).t('contact.error'))),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isMobile = Responsive.isMobile(context);

    if (_done) {
      return AppCard(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.softMint.withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded,
                  color: AppColors.deepTeal, size: 32),
            ),
            const SizedBox(height: 20),
            Text(
              l.t('contact.success'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
    }

    return AppCard(
      padding: EdgeInsets.all(isMobile ? 22 : 32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row(isMobile, [
              _field(l.t('contact.company'), _company, required: true),
              _field(l.t('contact.person'), _person, required: true),
            ]),
            const SizedBox(height: 16),
            _row(isMobile, [
              _field(l.t('contact.email'), _email,
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail),
              _field(l.t('contact.phone'), _phone,
                  keyboardType: TextInputType.phone),
            ]),
            const SizedBox(height: 16),
            _field(
              l.t('contact.vehicles'),
              _vehicles,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            _field(l.t('contact.message'), _message, maxLines: 4, required: true),
            const SizedBox(height: 24),
            AppButton(
              label: l.t('contact.cta'),
              icon: Icons.send_rounded,
              loading: _submitting,
              expand: isMobile,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(bool isMobile, List<Widget> children) {
    if (isMobile) {
      return Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            children[i],
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Expanded(child: children[i]),
        ],
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppColors.textDark)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator ??
              (required
                  ? (v) => (v == null || v.trim().isEmpty)
                      ? l.t('common.required')
                      : null
                  : null),
        ),
      ],
    );
  }

  String? _validateEmail(String? value) {
    final l = AppLocalizations.of(context);
    if (value == null || value.trim().isEmpty) return l.t('common.required');
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
    return ok ? null : l.t('common.required');
  }
}

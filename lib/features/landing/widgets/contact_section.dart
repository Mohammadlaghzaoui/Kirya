import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';
import '../../contact/widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isDesktop = Responsive.isDesktop(context);

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          eyebrow: l.t('contact.eyebrow'),
          title: l.t('contact.title'),
          subtitle: l.t('contact.subtitle'),
          alignment: CrossAxisAlignment.start,
        ),
        const SizedBox(height: 28),
        _ContactLine(Icons.email_outlined, AppConstants.salesEmail),
        const SizedBox(height: 14),
        _ContactLine(Icons.phone_outlined, AppConstants.supportPhone),
        const SizedBox(height: 14),
        const _ContactLine(Icons.location_on_outlined, 'Brussels, Belgium'),
      ],
    );

    return Container(
      width: double.infinity,
      color: AppColors.lightGrey.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        child: Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: isDesktop ? 4 : 0, child: info),
            SizedBox(width: isDesktop ? 48 : 0, height: isDesktop ? 0 : 36),
            Expanded(flex: isDesktop ? 6 : 0, child: const ContactForm()),
          ],
        ),
      ),
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.tealGreen.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.deepTeal, size: 18),
        ),
        const SizedBox(width: 14),
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

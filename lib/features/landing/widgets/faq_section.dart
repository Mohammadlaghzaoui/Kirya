import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  static const _faqs = <(String, String)>[
    ('faq.q1', 'faq.a1'),
    ('faq.q2', 'faq.a2'),
    ('faq.q3', 'faq.a3'),
    ('faq.q4', 'faq.a4'),
    ('faq.q5', 'faq.a5'),
    ('faq.q6', 'faq.a6'),
    ('faq.q7', 'faq.a7'),
    ('faq.q8', 'faq.a8'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        maxWidth: 880,
        child: Column(
          children: [
            SectionHeader(
              eyebrow: l.t('faq.eyebrow'),
              title: l.t('faq.title'),
            ),
            const SizedBox(height: 40),
            for (final faq in _faqs)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _FaqItem(
                  question: l.t(faq.$1),
                  answer: l.t(faq.$2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  const _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          tilePadding:
              EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 18 : 24, vertical: 6),
          childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
          onExpansionChanged: (v) => setState(() => _open = v),
          iconColor: AppColors.tealGreen,
          collapsedIconColor: AppColors.textMuted,
          title: Text(
            widget.question,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _open ? AppColors.deepTeal : AppColors.textDark,
                ),
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.answer,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColors.textMuted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

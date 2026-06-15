import 'package:flutter/material.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/responsive.dart';
import '../../../core/widgets/section_header.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  static const _steps = <(IconData, String, String)>[
    (Icons.checklist_rounded, 'how.step1.title', 'how.step1.desc'),
    (Icons.lock_rounded, 'how.step2.title', 'how.step2.desc'),
    (Icons.verified_user_rounded, 'how.step3.title', 'how.step3.desc'),
    (Icons.login_rounded, 'how.step4.title', 'how.step4.desc'),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final columns = Responsive.value<int>(context, mobile: 1, tablet: 2, desktop: 4);

    return Container(
      width: double.infinity,
      color: AppColors.lightGrey.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: ContentContainer(
        child: Column(
          children: [
            SectionHeader(
              eyebrow: l.t('how.eyebrow'),
              title: l.t('how.title'),
            ),
            const SizedBox(height: 44),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 18.0;
                final itemWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;
                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < _steps.length; i++)
                      SizedBox(
                        width: itemWidth,
                        child: _StepCard(
                          number: i + 1,
                          icon: _steps[i].$1,
                          title: l.t(_steps[i].$2),
                          description: l.t(_steps[i].$3),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  final int number;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      hoverable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  gradient: AppColors.tealGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const Spacer(),
              Icon(icon, color: AppColors.luxuryGold, size: 22),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

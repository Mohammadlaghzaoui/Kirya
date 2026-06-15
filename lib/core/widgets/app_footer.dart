import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../localization/app_localizations.dart';
import '../routing/route_names.dart';
import '../theme/app_colors.dart';
import 'brand_logo.dart';
import 'responsive.dart';

/// Dark brand footer with link columns and social icons.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.deepBlack,
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: ContentContainer(
        child: Column(
          children: [
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BrandLogo(onDark: true),
                      const SizedBox(height: 16),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 320),
                        child: Text(
                          l.t('footer.tagline'),
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          _SocialIcon(Icons.business_center_outlined),
                          _SocialIcon(Icons.camera_alt_outlined),
                          _SocialIcon(Icons.facebook_outlined),
                          _SocialIcon(Icons.alternate_email),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isMobile) const SizedBox(height: 36),
                _FooterColumn(
                  title: l.t('footer.product'),
                  links: [
                    (l.t('nav.packages'), Routes.packages),
                    (l.t('nav.features'), Routes.features),
                    (l.t('nav.howItWorks'), Routes.howItWorks),
                    (l.t('nav.companies'), Routes.companies),
                  ],
                ),
                if (isMobile) const SizedBox(height: 28),
                _FooterColumn(
                  title: l.t('footer.company'),
                  links: [
                    (l.t('nav.customers'), Routes.customers),
                    (l.t('nav.faq'), Routes.faq),
                    (l.t('nav.contact'), Routes.contact),
                    (l.t('nav.login'), Routes.login),
                  ],
                ),
                if (isMobile) const SizedBox(height: 28),
                _FooterColumn(
                  title: l.t('footer.legal'),
                  links: [
                    (l.t('footer.privacy'), Routes.home),
                    (l.t('footer.terms'), Routes.home),
                    (l.t('footer.cookies'), Routes.home),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Divider(color: Colors.white.withValues(alpha: 0.12)),
            const SizedBox(height: 20),
            Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '© ${DateTime.now().year} ${AppConstants.appName}. ${l.t('footer.rights')}',
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
                if (isMobile) const SizedBox(height: 8),
                Text(
                  AppConstants.salesEmail,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.links});
  final String title;
  final List<(String, String)> links;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: Responsive.isMobile(context) ? 0 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.luxuryGold,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          for (final link in links)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => context.go(link.$2),
                child: Text(
                  link.$1,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon(this.icon);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white70, size: 18),
    );
  }
}

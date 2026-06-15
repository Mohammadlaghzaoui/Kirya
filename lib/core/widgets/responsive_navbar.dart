import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../localization/app_localizations.dart';
import '../routing/route_names.dart';
import '../theme/app_colors.dart';
import '../../providers/auth_provider.dart';
import 'app_button.dart';
import 'brand_logo.dart';
import 'language_switcher.dart';
import 'responsive.dart';

class _NavItem {
  const _NavItem(this.labelKey, this.route);
  final String labelKey;
  final String route;
}

const _navItems = [
  _NavItem('nav.companies', Routes.companies),
  _NavItem('nav.customers', Routes.customers),
  _NavItem('nav.packages', Routes.packages),
  _NavItem('nav.features', Routes.features),
  _NavItem('nav.howItWorks', Routes.howItWorks),
  _NavItem('nav.faq', Routes.faq),
  _NavItem('nav.contact', Routes.contact),
];

/// Sticky, responsive top navigation with a mobile drawer trigger.
class ResponsiveNavbar extends ConsumerWidget implements PreferredSizeWidget {
  const ResponsiveNavbar({super.key, this.onMenuTap});

  final VoidCallback? onMenuTap;

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final user = ref.watch(authProvider);
    final isDesktop = Responsive.isDesktop(context);
    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        border: const Border(
          bottom: BorderSide(color: AppColors.lightGrey),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 76,
          child: ContentContainer(
            child: Row(
              children: [
                InkWell(
                  onTap: () => context.go(Routes.home),
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: BrandLogo(),
                  ),
                ),
                const Spacer(),
                if (isDesktop) ...[
                  ..._navItems.map(
                    (item) => _NavLink(
                      label: l.t(item.labelKey),
                      selected: currentRoute == item.route,
                      onTap: () => context.go(item.route),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const LanguageSwitcher(),
                  const SizedBox(width: 12),
                  if (user == null)
                    AppButton(
                      label: l.t('nav.login'),
                      variant: AppButtonVariant.outline,
                      dense: true,
                      onPressed: () => context.go(Routes.login),
                    )
                  else
                    AppButton(
                      label: user.isAdmin
                          ? l.t('admin.dashboard')
                          : l.t('nav.portal'),
                      variant: AppButtonVariant.outline,
                      dense: true,
                      onPressed: () => context
                          .go(user.isAdmin ? Routes.admin : Routes.portal),
                    ),
                  const SizedBox(width: 10),
                  AppButton(
                    label: l.t('nav.getStarted'),
                    variant: AppButtonVariant.primary,
                    dense: true,
                    onPressed: () => context.go(Routes.packages),
                  ),
                ] else ...[
                  const LanguageSwitcher(compact: true),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onMenuTap,
                    icon: const Icon(Icons.menu_rounded),
                    color: AppColors.textDark,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hover;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: widget.selected ? FontWeight.w700 : FontWeight.w500,
              color: active ? AppColors.deepTeal : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}

/// Drawer contents for mobile/tablet navigation.
class MobileNavDrawer extends ConsumerWidget {
  const MobileNavDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final user = ref.watch(authProvider);

    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: BrandLogo(),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: [
                  for (final item in _navItems)
                    ListTile(
                      title: Text(l.t(item.labelKey)),
                      onTap: () {
                        Navigator.of(context).pop();
                        context.go(item.route);
                      },
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppButton(
                    label: user == null
                        ? l.t('nav.login')
                        : (user.isAdmin
                            ? l.t('admin.dashboard')
                            : l.t('nav.portal')),
                    variant: AppButtonVariant.outline,
                    expand: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(user == null
                          ? Routes.login
                          : (user.isAdmin ? Routes.admin : Routes.portal));
                    },
                  ),
                  const SizedBox(height: 10),
                  AppButton(
                    label: l.t('nav.getStarted'),
                    expand: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(Routes.packages);
                    },
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

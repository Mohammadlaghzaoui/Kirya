import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/brand_logo.dart';

class AdminNavItem {
  const AdminNavItem(this.labelKey, this.icon, this.route);
  final String labelKey;
  final IconData icon;
  final String route;
}

const adminNavItems = [
  AdminNavItem('admin.dashboard', Icons.space_dashboard_rounded, Routes.admin),
  AdminNavItem('admin.settings', Icons.tune_rounded, Routes.adminSettings),
  AdminNavItem('admin.packages', Icons.inventory_2_rounded, Routes.adminPackages),
  AdminNavItem('admin.translations', Icons.translate_rounded, Routes.adminTranslations),
  AdminNavItem('admin.payments', Icons.payments_rounded, Routes.adminPayments),
  AdminNavItem('admin.companies', Icons.apartment_rounded, Routes.adminCompanies),
  AdminNavItem('admin.contacts', Icons.mark_email_unread_rounded, Routes.adminContacts),
  AdminNavItem('admin.cms', Icons.web_rounded, Routes.adminCms),
];

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key, required this.currentRoute, this.onTapItem});

  final String currentRoute;
  final VoidCallback? onTapItem;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Container(
      width: 264,
      color: AppColors.deepBlack,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 8),
              child: InkWell(
                onTap: () => context.go(Routes.home),
                child: const BrandLogo(onDark: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                l.t('admin.title').toUpperCase(),
                style: const TextStyle(
                  color: AppColors.luxuryGold,
                  fontSize: 10.5,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  for (final item in adminNavItems)
                    _SidebarTile(
                      icon: item.icon,
                      label: l.t(item.labelKey),
                      selected: currentRoute == item.route,
                      onTap: () {
                        onTapItem?.call();
                        context.go(item.route);
                      },
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _SidebarTile(
                icon: Icons.public_rounded,
                label: l.t('common.backHome'),
                selected: false,
                onTap: () => context.go(Routes.home),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: selected
            ? AppColors.tealGreen.withValues(alpha: 0.18)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 19,
                  color: selected ? AppColors.softMint : Colors.white60,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.white70,
                      fontWeight:
                          selected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

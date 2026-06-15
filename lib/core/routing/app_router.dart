import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/pages/admin_dashboard_page.dart';
import '../../features/admin/pages/cms_settings_page.dart';
import '../../features/admin/pages/companies_page.dart';
import '../../features/admin/pages/contacts_page.dart';
import '../../features/admin/pages/package_management_page.dart';
import '../../features/admin/pages/payments_page.dart';
import '../../features/admin/pages/translations_page.dart';
import '../../features/admin/pages/website_settings_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/checkout/pages/checkout_cancel_page.dart';
import '../../features/checkout/pages/checkout_success_page.dart';
import '../../features/landing/pages/companies_page.dart';
import '../../features/landing/pages/contact_page.dart';
import '../../features/landing/pages/customers_page.dart';
import '../../features/landing/pages/faq_page.dart';
import '../../features/landing/pages/features_page.dart';
import '../../features/landing/pages/home_page.dart';
import '../../features/landing/pages/how_it_works_page.dart';
import '../../features/landing/pages/packages_page.dart';
import '../../features/landing/pages/portal_page.dart';
import '../../providers/auth_provider.dart';
import 'route_names.dart';

/// Application router with protected admin and portal routes.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final user = ref.read(authProvider);
      final path = state.uri.path;
      final isAdminRoute = path.startsWith('/admin');
      final isPortalRoute = path == Routes.portal;

      // Admin pages: Super Admin / Admin only.
      if (isAdminRoute) {
        if (user == null) return '${Routes.login}?redirect=$path';
        if (!user.isAdmin) return Routes.home;
      }

      // Portal: active subscribers (or admins).
      if (isPortalRoute) {
        if (user == null) return '${Routes.login}?redirect=$path';
        final hasAccess = ref.read(hasPortalAccessProvider);
        if (!hasAccess) return Routes.packages;
      }
      return null;
    },
    routes: [
      GoRoute(path: Routes.home, builder: (_, __) => const HomePage()),
      GoRoute(
          path: Routes.companies, builder: (_, __) => const CompaniesPage()),
      GoRoute(
          path: Routes.customers, builder: (_, __) => const CustomersPage()),
      GoRoute(path: Routes.packages, builder: (_, __) => const PackagesPage()),
      GoRoute(path: Routes.features, builder: (_, __) => const FeaturesPage()),
      GoRoute(
          path: Routes.howItWorks,
          builder: (_, __) => const HowItWorksPage()),
      GoRoute(path: Routes.faq, builder: (_, __) => const FaqPage()),
      GoRoute(path: Routes.contact, builder: (_, __) => const ContactPage()),
      GoRoute(path: Routes.login, builder: (_, __) => const LoginPage()),
      GoRoute(path: Routes.portal, builder: (_, __) => const PortalPage()),

      // Checkout
      GoRoute(
        path: Routes.checkoutSuccess,
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return CheckoutSuccessPage(
            packageId: q['package'],
            cycle: q['cycle'],
            company: q['company'],
            email: q['email'],
          );
        },
      ),
      GoRoute(
          path: Routes.checkoutCancel,
          builder: (_, __) => const CheckoutCancelPage()),

      // Admin
      GoRoute(
          path: Routes.admin, builder: (_, __) => const AdminDashboardPage()),
      GoRoute(
          path: Routes.adminSettings,
          builder: (_, __) => const WebsiteSettingsPage()),
      GoRoute(
          path: Routes.adminPackages,
          builder: (_, __) => const PackageManagementPage()),
      GoRoute(
          path: Routes.adminTranslations,
          builder: (_, __) => const TranslationsPage()),
      GoRoute(
          path: Routes.adminPayments,
          builder: (_, __) => const PaymentsPage()),
      GoRoute(
          path: Routes.adminCompanies,
          builder: (_, __) => const AdminCompaniesPage()),
      GoRoute(
          path: Routes.adminContacts,
          builder: (_, __) => const ContactsPage()),
      GoRoute(
          path: Routes.adminCms, builder: (_, __) => const CmsSettingsPage()),
    ],
    errorBuilder: (context, state) => const HomePage(),
  );
});

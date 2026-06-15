import '../models/app_user.dart';
import '../models/company.dart';
import '../models/contact_request.dart';
import '../models/enums.dart';
import '../models/package_model.dart';
import '../models/payment.dart';
import '../models/subscription.dart';

/// Initial demo content for the in-memory backend. Mirrors the structure a real
/// Firestore/Supabase seed would use, so screens have realistic data to render.
class SeedData {
  SeedData._();

  static DateTime get _now => DateTime.now();

  static List<PackageModel> packages() => [
        PackageModel(
          id: 'pkg_rental_management',
          name: 'Rental Management',
          description:
              'Pour les sociétés de location qui veulent digitaliser leur flotte, leurs réservations et leur flux de location.',
          features: const [
            'Gestion de flotte',
            'Disponibilité des véhicules',
            'Vue des réservations',
            'Gestion des clients',
            'Contrats de location digitaux',
            'Flux check-in / check-out',
            'Enregistrement des dommages',
            'Stockage des documents véhicule',
            'Comptes du personnel',
            'Rapports de base',
            'Accès en ligne sécurisé',
          ],
          monthlyPrice: 49,
          yearlyPrice: 490,
          setupFee: 0,
          recommended: false,
          order: 0,
          stripePriceIdMonthly: 'price_rental_monthly_placeholder',
          stripePriceIdYearly: 'price_rental_yearly_placeholder',
          createdAt: _now,
          updatedAt: _now,
        ),
        PackageModel(
          id: 'pkg_rental_business',
          name: 'Rental Management + Business & Accounting',
          description:
              'Pour les sociétés qui veulent une gestion complète, avec suivi financier, facturation et rapports de management.',
          inheritsFromName: 'Rental Management',
          features: const [
            'Tableau de bord avancé',
            'Gestion des factures',
            'Aperçu comptable',
            'Rapports de revenus',
            'Suivi des dépenses',
            'Aperçu TVA',
            'Rapprochement des paiements',
            'Aperçu des paiements Stripe',
            'Solde client',
            'Exports financiers',
            'Rapports de management',
            'Support multi-agences',
            'Permissions de rôles avancées',
          ],
          monthlyPrice: 89,
          yearlyPrice: 890,
          setupFee: 0,
          recommended: true,
          order: 1,
          stripePriceIdMonthly: 'price_business_monthly_placeholder',
          stripePriceIdYearly: 'price_business_yearly_placeholder',
          createdAt: _now,
          updatedAt: _now,
        ),
      ];

  static List<AppUser> users() => [
        AppUser(
          id: 'user_superadmin',
          email: 'admin@kirya.app',
          displayName: 'Platform Admin',
          role: UserRole.superAdmin,
          createdAt: _now,
          updatedAt: _now,
        ),
        AppUser(
          id: 'user_owner',
          email: 'owner@kirya.app',
          displayName: 'Rental Owner',
          role: UserRole.rentalCompanyOwner,
          companyId: 'company_demo',
          createdAt: _now,
          updatedAt: _now,
        ),
      ];

  static List<Company> companies() => [
        Company(
          id: 'company_demo',
          name: 'Brussels Premium Cars',
          contactEmail: 'owner@kirya.app',
          contactPhone: '+32 2 111 22 33',
          vehicleCount: 24,
          ownerUserId: 'user_owner',
          activeSubscriptionId: 'sub_demo',
          portalAccess: true,
          createdAt: _now,
          updatedAt: _now,
        ),
        Company(
          id: 'company_antwerp',
          name: 'Antwerp Fleet Services',
          contactEmail: 'info@antwerpfleet.be',
          contactPhone: '+32 3 222 33 44',
          vehicleCount: 58,
          portalAccess: true,
          createdAt: _now,
          updatedAt: _now,
        ),
      ];

  static List<Subscription> subscriptions() => [
        Subscription(
          id: 'sub_demo',
          companyId: 'company_demo',
          packageId: 'pkg_rental_business',
          packageName: 'Rental Management + Business & Accounting',
          billingCycle: BillingCycle.yearly,
          subscriptionStatus: SubscriptionStatus.active,
          stripeCustomerId: 'cus_demo123',
          stripeSubscriptionId: 'sub_stripe_demo123',
          currentPeriodEnd: _now.add(const Duration(days: 300)),
          createdAt: _now,
          updatedAt: _now,
        ),
        Subscription(
          id: 'sub_antwerp',
          companyId: 'company_antwerp',
          packageId: 'pkg_rental_management',
          packageName: 'Rental Management',
          billingCycle: BillingCycle.monthly,
          subscriptionStatus: SubscriptionStatus.active,
          stripeCustomerId: 'cus_antwerp456',
          stripeSubscriptionId: 'sub_stripe_antwerp456',
          currentPeriodEnd: _now.add(const Duration(days: 20)),
          createdAt: _now,
          updatedAt: _now,
        ),
      ];

  static List<Payment> payments() => [
        Payment(
          id: 'pay_demo',
          companyId: 'company_demo',
          companyName: 'Brussels Premium Cars',
          packageName: 'Rental Management + Business & Accounting',
          amount: 890,
          billingCycle: BillingCycle.yearly,
          paymentStatus: PaymentStatus.succeeded,
          subscriptionStatus: SubscriptionStatus.active,
          stripeCustomerId: 'cus_demo123',
          stripeSubscriptionId: 'sub_stripe_demo123',
          lastPaymentAt: _now.subtract(const Duration(days: 65)),
          createdAt: _now.subtract(const Duration(days: 65)),
          updatedAt: _now.subtract(const Duration(days: 65)),
        ),
        Payment(
          id: 'pay_antwerp',
          companyId: 'company_antwerp',
          companyName: 'Antwerp Fleet Services',
          packageName: 'Rental Management',
          amount: 49,
          billingCycle: BillingCycle.monthly,
          paymentStatus: PaymentStatus.succeeded,
          subscriptionStatus: SubscriptionStatus.active,
          stripeCustomerId: 'cus_antwerp456',
          stripeSubscriptionId: 'sub_stripe_antwerp456',
          lastPaymentAt: _now.subtract(const Duration(days: 8)),
          createdAt: _now.subtract(const Duration(days: 38)),
          updatedAt: _now.subtract(const Duration(days: 8)),
        ),
      ];

  static List<ContactRequest> contactRequests() => [
        ContactRequest(
          id: 'contact_1',
          companyName: 'Ghent Mobility',
          contactPerson: 'Lucas Peeters',
          email: 'lucas@ghentmobility.be',
          phone: '+32 9 333 44 55',
          vehicleCount: 32,
          message:
              'Nous souhaitons digitaliser notre flotte de 32 véhicules. Pouvez-vous nous proposer une démonstration ?',
          createdAt: _now.subtract(const Duration(days: 2)),
          updatedAt: _now.subtract(const Duration(days: 2)),
        ),
      ];
}

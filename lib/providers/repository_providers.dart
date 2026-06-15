import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/navigation_service.dart';
import '../core/services/stripe_service.dart';
import '../repositories/auth_repository.dart';
import '../repositories/billing_repository.dart';
import '../repositories/company_repository.dart';
import '../repositories/contact_repository.dart';
import '../repositories/kirya_store.dart';
import '../repositories/package_repository.dart';
import '../repositories/settings_repository.dart';

/// Single shared in-memory backend instance.
final kiryaStoreProvider = Provider<KiryaStore>((ref) => KiryaStore());

final packageRepositoryProvider = Provider<PackageRepository>(
  (ref) => PackageRepository(ref.watch(kiryaStoreProvider)),
);

final companyRepositoryProvider = Provider<CompanyRepository>(
  (ref) => CompanyRepository(ref.watch(kiryaStoreProvider)),
);

final billingRepositoryProvider = Provider<BillingRepository>(
  (ref) => BillingRepository(ref.watch(kiryaStoreProvider)),
);

final contactRepositoryProvider = Provider<ContactRepository>(
  (ref) => ContactRepository(ref.watch(kiryaStoreProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(kiryaStoreProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(kiryaStoreProvider)),
);

final stripeServiceProvider =
    Provider<StripeService>((ref) => const StripeService());

final navigationServiceProvider =
    Provider<NavigationService>((ref) => const NavigationService());

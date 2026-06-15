import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/company.dart';
import '../models/contact_request.dart';
import '../models/package_model.dart';
import '../models/payment.dart';
import '../models/website_settings.dart';
import 'repository_providers.dart';

/// Bumped to force dependent providers to refetch after a mutation.
final dataRevisionProvider = StateProvider<int>((ref) => 0);

void bumpRevision(Ref ref) =>
    ref.read(dataRevisionProvider.notifier).state++;

final activePackagesProvider = FutureProvider<List<PackageModel>>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(packageRepositoryProvider).active();
});

final allPackagesProvider = FutureProvider<List<PackageModel>>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(packageRepositoryProvider).all();
});

final websiteSettingsProvider = FutureProvider<WebsiteSettings>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(settingsRepositoryProvider).get();
});

final paymentsProvider = FutureProvider<List<Payment>>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(billingRepositoryProvider).payments();
});

final companiesProvider = FutureProvider<List<Company>>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(companyRepositoryProvider).all();
});

final contactRequestsProvider = FutureProvider<List<ContactRequest>>((ref) {
  ref.watch(dataRevisionProvider);
  return ref.watch(contactRepositoryProvider).all();
});

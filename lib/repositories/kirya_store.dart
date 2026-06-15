import '../models/app_user.dart';
import '../models/company.dart';
import '../models/contact_request.dart';
import '../models/package_model.dart';
import '../models/payment.dart';
import '../models/subscription.dart';
import '../models/website_settings.dart';
import 'seed_data.dart';

/// In-memory backend mirroring the Firestore/Supabase collections.
///
/// This is the single source of truth for the demo. To switch to a real
/// backend, implement the same repository method signatures against Firebase or
/// Supabase and bind them in `providers/` — feature code never touches the store
/// directly.
class KiryaStore {
  KiryaStore() {
    packages = SeedData.packages();
    users = SeedData.users();
    companies = SeedData.companies();
    subscriptions = SeedData.subscriptions();
    payments = SeedData.payments();
    contactRequests = SeedData.contactRequests();
    settings = const WebsiteSettings();
  }

  late List<PackageModel> packages;
  late List<AppUser> users;
  late List<Company> companies;
  late List<Subscription> subscriptions;
  late List<Payment> payments;
  late List<ContactRequest> contactRequests;
  late WebsiteSettings settings;

  String newId(String prefix) =>
      '${prefix}_${DateTime.now().microsecondsSinceEpoch}';
}

import '../models/company.dart';
import '../models/enums.dart';
import '../models/payment.dart';
import '../models/subscription.dart';
import 'kirya_store.dart';

/// Result of activating access after a successful checkout.
class ActivationResult {
  const ActivationResult({
    required this.company,
    required this.subscription,
    required this.payment,
  });
  final Company company;
  final Subscription subscription;
  final Payment payment;
}

/// Handles the post-payment domain logic: create/activate the company, create
/// the subscription, record the payment and grant portal access.
///
/// In production this mirrors what the Stripe webhook handler does server-side;
/// here it runs client-side against the in-memory store so the success page can
/// reflect a real state change.
class BillingRepository {
  BillingRepository(this._store);
  final KiryaStore _store;

  Future<List<Subscription>> subscriptions() async =>
      [..._store.subscriptions];

  Future<List<Payment>> payments() async {
    final list = [..._store.payments]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// Activates (or creates) a company subscription after a successful payment.
  Future<ActivationResult> activateAfterPayment({
    required String packageId,
    required String packageName,
    required BillingCycle billingCycle,
    required double amount,
    required String companyName,
    required String contactEmail,
    String? stripeCustomerId,
    String? stripeSubscriptionId,
  }) async {
    final now = DateTime.now();

    // 1. Find or create the company.
    Company company;
    final existingIndex = _store.companies.indexWhere(
      (c) => c.contactEmail.toLowerCase() == contactEmail.toLowerCase(),
    );
    if (existingIndex != -1) {
      company = _store.companies[existingIndex];
    } else {
      company = Company(
        id: _store.newId('company'),
        name: companyName,
        contactEmail: contactEmail,
        createdAt: now,
        updatedAt: now,
      );
      _store.companies.add(company);
    }

    // 2. Create the subscription (active → grants portal access).
    final subscription = Subscription(
      id: _store.newId('sub'),
      companyId: company.id,
      packageId: packageId,
      packageName: packageName,
      billingCycle: billingCycle,
      subscriptionStatus: SubscriptionStatus.active,
      stripeCustomerId: stripeCustomerId,
      stripeSubscriptionId: stripeSubscriptionId,
      currentPeriodEnd: now.add(
        billingCycle == BillingCycle.yearly
            ? const Duration(days: 365)
            : const Duration(days: 30),
      ),
      createdAt: now,
      updatedAt: now,
    );
    _store.subscriptions.add(subscription);

    // 3. Grant portal access and assign owner linkage on the company.
    company = company.copyWith(
      activeSubscriptionId: subscription.id,
      portalAccess: true,
      status: RecordStatus.active,
    );
    _store.companies[
        _store.companies.indexWhere((c) => c.id == company.id)] = company;

    // 4. Record the payment.
    final payment = Payment(
      id: _store.newId('pay'),
      companyId: company.id,
      companyName: company.name,
      packageName: packageName,
      amount: amount,
      billingCycle: billingCycle,
      paymentStatus: PaymentStatus.succeeded,
      subscriptionStatus: SubscriptionStatus.active,
      stripeCustomerId: stripeCustomerId,
      stripeSubscriptionId: stripeSubscriptionId,
      lastPaymentAt: now,
      createdAt: now,
      updatedAt: now,
    );
    _store.payments.add(payment);

    return ActivationResult(
      company: company,
      subscription: subscription,
      payment: payment,
    );
  }
}

import 'package:flutter/foundation.dart';

import '../../models/enums.dart';
import '../../models/package_model.dart';
import '../constants/app_constants.dart';

/// Describes where the app should send the user to complete payment.
class CheckoutSession {
  const CheckoutSession({
    required this.isDemo,
    required this.redirectPath,
    this.stripeCheckoutUrl,
    this.sessionId,
  });

  /// True when running without a real backend — the app simulates a successful
  /// payment by routing straight to the success page.
  final bool isDemo;

  /// In-app route to navigate to (used in demo mode and for cancel handling).
  final String redirectPath;

  /// Hosted Stripe Checkout URL (production).
  final String? stripeCheckoutUrl;

  final String? sessionId;
}

/// Stripe Checkout integration.
///
/// Production flow:
///   1. POST package + cycle + customer to [AppConstants.checkoutSessionEndpoint]
///      (a serverless function) which creates a Stripe Checkout Session with the
///      package's price ID, optional setup fee, success_url and cancel_url.
///   2. The endpoint returns a session id / hosted URL.
///   3. Redirect the browser to the hosted Checkout URL (or use Stripe.js
///      `redirectToCheckout({ sessionId })`).
///   4. Stripe redirects back to /checkout/success or /checkout/cancel.
///   5. A Stripe webhook ([AppConstants.stripeWebhookEndpoint]) confirms payment
///      server-side and activates the subscription (see BillingRepository).
///
/// Demo flow (USE_REMOTE_BACKEND=false): the session points at the in-app
/// success route so the whole journey is demonstrable without secrets.
class StripeService {
  const StripeService();

  Future<CheckoutSession> createCheckoutSession({
    required PackageModel package,
    required BillingCycle cycle,
    String? companyName,
    String? email,
  }) async {
    final params = <String, String>{
      'package': package.id,
      'cycle': cycle.name,
      if (companyName != null && companyName.isNotEmpty) 'company': companyName,
      if (email != null && email.isNotEmpty) 'email': email,
    };
    final query = Uri(queryParameters: params).query;
    final successPath = '/checkout/success?$query';

    if (!AppConstants.useRemoteBackend) {
      // Simulate latency then return the in-app success route.
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return CheckoutSession(isDemo: true, redirectPath: successPath);
    }

    // --- Production: call the backend to create a real Checkout Session. ---
    try {
      // Example (uncomment when wiring a backend):
      // final res = await http.post(
      //   Uri.parse(AppConstants.checkoutSessionEndpoint),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({
      //     'priceId': package.stripePriceIdFor(cycle),
      //     'cycle': cycle.name,
      //     'setupFee': package.setupFee,
      //     'companyName': companyName,
      //     'email': email,
      //     'successUrl': '${Uri.base.origin}/#$successPath',
      //     'cancelUrl': '${Uri.base.origin}/#/checkout/cancel',
      //   }),
      // );
      // final data = jsonDecode(res.body) as Map<String, dynamic>;
      // return CheckoutSession(
      //   isDemo: false,
      //   redirectPath: '/checkout/cancel',
      //   stripeCheckoutUrl: data['url'] as String?,
      //   sessionId: data['id'] as String?,
      // );
      throw UnimplementedError(
        'Wire createCheckoutSession to your backend / Stripe endpoint.',
      );
    } catch (e) {
      debugPrint('StripeService.createCheckoutSession failed: $e');
      rethrow;
    }
  }
}

/// Static, environment-level configuration for Kirya.
///
/// Values that should change per deployment (Stripe keys, portal URL, backend
/// flags) live here so they can be wired to `--dart-define` in CI/CD without
/// touching feature code.
class AppConstants {
  AppConstants._();

  static const String appName = 'Kirya';
  static const String brandTagline =
      'Premium vehicle rental platform';

  /// Placeholder portal URL — replace with the real rental management portal.
  static const String portalUrl = '/portal';

  /// Default contact details (also editable from the admin CMS).
  static const String supportEmail = 'support@kirya.app';
  static const String salesEmail = 'sales@kirya.app';
  static const String supportPhone = '+32 2 000 00 00';

  // ---- Stripe -------------------------------------------------------------
  // Provide via: flutter build web --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_...
  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: 'pk_test_placeholder',
  );

  /// Backend endpoint that creates a Stripe Checkout Session and returns its id.
  /// In production this is a serverless function / Cloud Function.
  static const String checkoutSessionEndpoint = String.fromEnvironment(
    'CHECKOUT_SESSION_ENDPOINT',
    defaultValue: '/api/create-checkout-session',
  );

  /// Webhook endpoint placeholder (handled server-side, documented here).
  static const String stripeWebhookEndpoint = '/api/stripe/webhook';

  // ---- Backend ------------------------------------------------------------
  /// When false the app runs entirely on the in-memory mock backend so the
  /// site can be demoed without Firebase/Supabase credentials.
  static const bool useRemoteBackend = bool.fromEnvironment(
    'USE_REMOTE_BACKEND',
    defaultValue: false,
  );

  // ---- Misc ---------------------------------------------------------------
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 700);

  static const double maxContentWidth = 1200;
  static const double mobileBreakpoint = 640;
  static const double tabletBreakpoint = 1024;
}

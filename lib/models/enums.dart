/// Roles used across authentication and protected routing.
enum UserRole {
  superAdmin,
  admin,
  rentalCompanyOwner,
  customer;

  static UserRole fromName(String value) => UserRole.values.firstWhere(
        (r) => r.name == value,
        orElse: () => UserRole.customer,
      );

  bool get isAdmin => this == UserRole.superAdmin || this == UserRole.admin;
}

/// Lifecycle status shared by most records (`status` audit field).
enum RecordStatus {
  active,
  inactive,
  archived;

  static RecordStatus fromName(String value) => RecordStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => RecordStatus.active,
      );
}

enum BillingCycle {
  monthly,
  yearly;

  static BillingCycle fromName(String value) => BillingCycle.values.firstWhere(
        (b) => b.name == value,
        orElse: () => BillingCycle.monthly,
      );
}

enum SubscriptionStatus {
  pending,
  active,
  pastDue,
  canceled,
  incomplete;

  static SubscriptionStatus fromName(String value) =>
      SubscriptionStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => SubscriptionStatus.pending,
      );

  bool get grantsPortalAccess => this == SubscriptionStatus.active;
}

enum PaymentStatus {
  pending,
  succeeded,
  failed,
  refunded;

  static PaymentStatus fromName(String value) =>
      PaymentStatus.values.firstWhere(
        (s) => s.name == value,
        orElse: () => PaymentStatus.pending,
      );
}

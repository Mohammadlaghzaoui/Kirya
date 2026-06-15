import 'enums.dart';

/// A company's subscription to a package, mirroring the Stripe subscription.
class Subscription {
  const Subscription({
    required this.id,
    required this.companyId,
    required this.packageId,
    required this.packageName,
    required this.billingCycle,
    required this.subscriptionStatus,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.currentPeriodEnd,
    this.status = RecordStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'system',
  });

  final String id;
  final String companyId;
  final String packageId;
  final String packageName;
  final BillingCycle billingCycle;
  final SubscriptionStatus subscriptionStatus;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final DateTime? currentPeriodEnd;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  bool get grantsPortalAccess => subscriptionStatus.grantsPortalAccess;

  Subscription copyWith({
    SubscriptionStatus? subscriptionStatus,
    BillingCycle? billingCycle,
    String? stripeCustomerId,
    String? stripeSubscriptionId,
    DateTime? currentPeriodEnd,
    RecordStatus? status,
    DateTime? updatedAt,
  }) =>
      Subscription(
        id: id,
        companyId: companyId,
        packageId: packageId,
        packageName: packageName,
        billingCycle: billingCycle ?? this.billingCycle,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        stripeSubscriptionId: stripeSubscriptionId ?? this.stripeSubscriptionId,
        currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
        status: status ?? this.status,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        createdBy: createdBy,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'companyId': companyId,
        'packageId': packageId,
        'packageName': packageName,
        'billingCycle': billingCycle.name,
        'subscriptionStatus': subscriptionStatus.name,
        'stripeCustomerId': stripeCustomerId,
        'stripeSubscriptionId': stripeSubscriptionId,
        'currentPeriodEnd': currentPeriodEnd?.toIso8601String(),
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory Subscription.fromMap(Map<String, dynamic> map) => Subscription(
        id: map['id'] as String,
        companyId: map['companyId'] as String,
        packageId: map['packageId'] as String,
        packageName: map['packageName'] as String,
        billingCycle: BillingCycle.fromName(map['billingCycle'] as String),
        subscriptionStatus:
            SubscriptionStatus.fromName(map['subscriptionStatus'] as String),
        stripeCustomerId: map['stripeCustomerId'] as String?,
        stripeSubscriptionId: map['stripeSubscriptionId'] as String?,
        currentPeriodEnd: map['currentPeriodEnd'] == null
            ? null
            : DateTime.parse(map['currentPeriodEnd'] as String),
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}

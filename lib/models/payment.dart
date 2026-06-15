import 'enums.dart';

/// A payment / invoice record linked to a company and subscription.
class Payment {
  const Payment({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.packageName,
    required this.amount,
    this.currency = '€',
    required this.billingCycle,
    required this.paymentStatus,
    required this.subscriptionStatus,
    this.stripeCustomerId,
    this.stripeSubscriptionId,
    this.lastPaymentAt,
    this.status = RecordStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'system',
  });

  final String id;
  final String companyId;
  final String companyName;
  final String packageName;
  final double amount;
  final String currency;
  final BillingCycle billingCycle;
  final PaymentStatus paymentStatus;
  final SubscriptionStatus subscriptionStatus;
  final String? stripeCustomerId;
  final String? stripeSubscriptionId;
  final DateTime? lastPaymentAt;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  Map<String, dynamic> toMap() => {
        'id': id,
        'companyId': companyId,
        'companyName': companyName,
        'packageName': packageName,
        'amount': amount,
        'currency': currency,
        'billingCycle': billingCycle.name,
        'paymentStatus': paymentStatus.name,
        'subscriptionStatus': subscriptionStatus.name,
        'stripeCustomerId': stripeCustomerId,
        'stripeSubscriptionId': stripeSubscriptionId,
        'lastPaymentAt': lastPaymentAt?.toIso8601String(),
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory Payment.fromMap(Map<String, dynamic> map) => Payment(
        id: map['id'] as String,
        companyId: map['companyId'] as String,
        companyName: map['companyName'] as String,
        packageName: map['packageName'] as String,
        amount: (map['amount'] as num).toDouble(),
        currency: map['currency'] as String? ?? '€',
        billingCycle: BillingCycle.fromName(map['billingCycle'] as String),
        paymentStatus: PaymentStatus.fromName(map['paymentStatus'] as String),
        subscriptionStatus:
            SubscriptionStatus.fromName(map['subscriptionStatus'] as String),
        stripeCustomerId: map['stripeCustomerId'] as String?,
        stripeSubscriptionId: map['stripeSubscriptionId'] as String?,
        lastPaymentAt: map['lastPaymentAt'] == null
            ? null
            : DateTime.parse(map['lastPaymentAt'] as String),
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}

import 'enums.dart';

/// A B2B subscription package shown on the landing page and editable from the
/// admin "Package Management" screen.
class PackageModel {
  const PackageModel({
    required this.id,
    required this.name,
    required this.description,
    required this.features,
    required this.monthlyPrice,
    required this.yearlyPrice,
    this.setupFee = 0,
    this.currency = '€',
    this.recommended = false,
    this.order = 0,
    this.status = RecordStatus.active,
    this.stripePriceIdMonthly,
    this.stripePriceIdYearly,
    this.inheritsFromName,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'system',
  });

  final String id;
  final String name;
  final String description;
  final List<String> features;
  final double monthlyPrice;
  final double yearlyPrice;
  final double setupFee;
  final String currency;
  final bool recommended;
  final int order;
  final RecordStatus status;
  final String? stripePriceIdMonthly;
  final String? stripePriceIdYearly;

  /// Optional name of the package whose features are inherited ("Everything in
  /// {plan}, plus:"). Used purely for presentation.
  final String? inheritsFromName;

  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  bool get isActive => status == RecordStatus.active;

  double priceFor(BillingCycle cycle) =>
      cycle == BillingCycle.monthly ? monthlyPrice : yearlyPrice;

  String? stripePriceIdFor(BillingCycle cycle) =>
      cycle == BillingCycle.monthly ? stripePriceIdMonthly : stripePriceIdYearly;

  PackageModel copyWith({
    String? name,
    String? description,
    List<String>? features,
    double? monthlyPrice,
    double? yearlyPrice,
    double? setupFee,
    String? currency,
    bool? recommended,
    int? order,
    RecordStatus? status,
    String? stripePriceIdMonthly,
    String? stripePriceIdYearly,
    String? inheritsFromName,
    DateTime? updatedAt,
  }) {
    return PackageModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      features: features ?? this.features,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      yearlyPrice: yearlyPrice ?? this.yearlyPrice,
      setupFee: setupFee ?? this.setupFee,
      currency: currency ?? this.currency,
      recommended: recommended ?? this.recommended,
      order: order ?? this.order,
      status: status ?? this.status,
      stripePriceIdMonthly: stripePriceIdMonthly ?? this.stripePriceIdMonthly,
      stripePriceIdYearly: stripePriceIdYearly ?? this.stripePriceIdYearly,
      inheritsFromName: inheritsFromName ?? this.inheritsFromName,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      createdBy: createdBy,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'features': features,
        'monthlyPrice': monthlyPrice,
        'yearlyPrice': yearlyPrice,
        'setupFee': setupFee,
        'currency': currency,
        'recommended': recommended,
        'order': order,
        'status': status.name,
        'stripePriceIdMonthly': stripePriceIdMonthly,
        'stripePriceIdYearly': stripePriceIdYearly,
        'inheritsFromName': inheritsFromName,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory PackageModel.fromMap(Map<String, dynamic> map) => PackageModel(
        id: map['id'] as String,
        name: map['name'] as String,
        description: map['description'] as String,
        features: (map['features'] as List).map((e) => e.toString()).toList(),
        monthlyPrice: (map['monthlyPrice'] as num).toDouble(),
        yearlyPrice: (map['yearlyPrice'] as num).toDouble(),
        setupFee: (map['setupFee'] as num?)?.toDouble() ?? 0,
        currency: map['currency'] as String? ?? '€',
        recommended: map['recommended'] as bool? ?? false,
        order: map['order'] as int? ?? 0,
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        stripePriceIdMonthly: map['stripePriceIdMonthly'] as String?,
        stripePriceIdYearly: map['stripePriceIdYearly'] as String?,
        inheritsFromName: map['inheritsFromName'] as String?,
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}

import 'enums.dart';

/// A rental company (B2B tenant). Created or activated after successful payment.
class Company {
  const Company({
    required this.id,
    required this.name,
    required this.contactEmail,
    this.contactPhone,
    this.vehicleCount,
    this.ownerUserId,
    this.activeSubscriptionId,
    this.portalAccess = false,
    this.status = RecordStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'system',
  });

  final String id;
  final String name;
  final String contactEmail;
  final String? contactPhone;
  final int? vehicleCount;
  final String? ownerUserId;
  final String? activeSubscriptionId;
  final bool portalAccess;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  Company copyWith({
    String? name,
    String? contactEmail,
    String? contactPhone,
    int? vehicleCount,
    String? ownerUserId,
    String? activeSubscriptionId,
    bool? portalAccess,
    RecordStatus? status,
    DateTime? updatedAt,
  }) =>
      Company(
        id: id,
        name: name ?? this.name,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        vehicleCount: vehicleCount ?? this.vehicleCount,
        ownerUserId: ownerUserId ?? this.ownerUserId,
        activeSubscriptionId: activeSubscriptionId ?? this.activeSubscriptionId,
        portalAccess: portalAccess ?? this.portalAccess,
        status: status ?? this.status,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        createdBy: createdBy,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'contactEmail': contactEmail,
        'contactPhone': contactPhone,
        'vehicleCount': vehicleCount,
        'ownerUserId': ownerUserId,
        'activeSubscriptionId': activeSubscriptionId,
        'portalAccess': portalAccess,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        id: map['id'] as String,
        name: map['name'] as String,
        contactEmail: map['contactEmail'] as String,
        contactPhone: map['contactPhone'] as String?,
        vehicleCount: map['vehicleCount'] as int?,
        ownerUserId: map['ownerUserId'] as String?,
        activeSubscriptionId: map['activeSubscriptionId'] as String?,
        portalAccess: map['portalAccess'] as bool? ?? false,
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}

import 'enums.dart';

/// An authenticated principal: super admin, admin, rental company owner or
/// customer.
class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    this.companyId,
    this.status = RecordStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'system',
  });

  final String id;
  final String email;
  final String displayName;
  final UserRole role;
  final String? companyId;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  bool get isAdmin => role.isAdmin;
  bool get isCompanyOwner => role == UserRole.rentalCompanyOwner;

  AppUser copyWith({
    String? displayName,
    UserRole? role,
    String? companyId,
    RecordStatus? status,
    DateTime? updatedAt,
  }) =>
      AppUser(
        id: id,
        email: email,
        displayName: displayName ?? this.displayName,
        role: role ?? this.role,
        companyId: companyId ?? this.companyId,
        status: status ?? this.status,
        createdAt: createdAt,
        updatedAt: updatedAt ?? DateTime.now(),
        createdBy: createdBy,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'displayName': displayName,
        'role': role.name,
        'companyId': companyId,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory AppUser.fromMap(Map<String, dynamic> map) => AppUser(
        id: map['id'] as String,
        email: map['email'] as String,
        displayName: map['displayName'] as String,
        role: UserRole.fromName(map['role'] as String),
        companyId: map['companyId'] as String?,
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'system',
      );
}

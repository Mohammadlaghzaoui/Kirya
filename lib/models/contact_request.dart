import 'enums.dart';

/// A "Request a demonstration" lead captured from the contact form.
class ContactRequest {
  const ContactRequest({
    required this.id,
    required this.companyName,
    required this.contactPerson,
    required this.email,
    this.phone,
    this.vehicleCount,
    required this.message,
    this.handled = false,
    this.status = RecordStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy = 'public',
  });

  final String id;
  final String companyName;
  final String contactPerson;
  final String email;
  final String? phone;
  final int? vehicleCount;
  final String message;
  final bool handled;
  final RecordStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;

  ContactRequest copyWith({bool? handled, RecordStatus? status}) =>
      ContactRequest(
        id: id,
        companyName: companyName,
        contactPerson: contactPerson,
        email: email,
        phone: phone,
        vehicleCount: vehicleCount,
        message: message,
        handled: handled ?? this.handled,
        status: status ?? this.status,
        createdAt: createdAt,
        updatedAt: DateTime.now(),
        createdBy: createdBy,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'companyName': companyName,
        'contactPerson': contactPerson,
        'email': email,
        'phone': phone,
        'vehicleCount': vehicleCount,
        'message': message,
        'handled': handled,
        'status': status.name,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
      };

  factory ContactRequest.fromMap(Map<String, dynamic> map) => ContactRequest(
        id: map['id'] as String,
        companyName: map['companyName'] as String,
        contactPerson: map['contactPerson'] as String,
        email: map['email'] as String,
        phone: map['phone'] as String?,
        vehicleCount: map['vehicleCount'] as int?,
        message: map['message'] as String,
        handled: map['handled'] as bool? ?? false,
        status: RecordStatus.fromName(map['status'] as String? ?? 'active'),
        createdAt: DateTime.parse(map['createdAt'] as String),
        updatedAt: DateTime.parse(map['updatedAt'] as String),
        createdBy: map['createdBy'] as String? ?? 'public',
      );
}

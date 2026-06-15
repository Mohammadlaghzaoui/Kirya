/// Append-only audit trail entry (admin actions, subscription changes, etc.).
class AuditLog {
  const AuditLog({
    required this.id,
    required this.action,
    required this.entity,
    this.entityId,
    this.actorId = 'system',
    this.metadata = const {},
    required this.createdAt,
  });

  final String id;
  final String action;
  final String entity;
  final String? entityId;
  final String actorId;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'action': action,
        'entity': entity,
        'entityId': entityId,
        'actorId': actorId,
        'metadata': metadata,
        'createdAt': createdAt.toIso8601String(),
      };
}

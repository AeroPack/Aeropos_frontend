import 'enums/sync_status.dart';

class Brand {
  final int id;
  final String uuid;
  final String name;
  final String? description;
  final bool isActive;
  final SyncStatus syncStatus;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  Brand({
    required this.id,
    required this.uuid,
    required this.name,
    this.description,
    this.isActive = true,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'description': description,
      'is_active': isActive,
      'sync_status': syncStatus.value,
      'is_deleted': isDeleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      syncStatus: SyncStatus.fromValue(json['sync_status'] ?? 0),
      isDeleted: json['is_deleted'] == 1 || json['is_deleted'] == true,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }
}

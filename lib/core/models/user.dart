import 'enums/sync_status.dart';

class User {
  final int id;
  final String uuid;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String role;
  final double creditLimit;
  final double currentBalance;

  final SyncStatus syncStatus;
  final bool isDeleted;
  final List<String> permissions;
  final String? password;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.role = 'customer',
    this.creditLimit = 0.0,
    this.currentBalance = 0.0,
    this.syncStatus = SyncStatus.synced,
    this.isDeleted = false,
    this.permissions = const [],
    this.password,
    this.isEmailVerified = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'role': role,
      'credit_limit': creditLimit,
      'current_balance': currentBalance,
      'sync_status': syncStatus.value,
      'is_deleted': isDeleted,
      'permissions': permissions,
      'password': password,
      'is_email_verified': isEmailVerified,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      role: json['role'] ?? 'employee',
      creditLimit: (json['credit_limit'] ?? 0).toDouble(),
      currentBalance: (json['current_balance'] ?? 0).toDouble(),
      syncStatus: SyncStatus.fromValue(json['sync_status'] ?? 0),
      isDeleted: json['is_deleted'] == 1 || json['is_deleted'] == true,
      permissions:
          (json['permissions'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      password: json['password'],
      isEmailVerified:
          json['isEmailVerified'] == true || json['is_email_verified'] == true,
    );
  }

  User copyWith({
    int? id,
    String? uuid,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? role,
    double? creditLimit,
    double? currentBalance,
    SyncStatus? syncStatus,
    bool? isDeleted,
    List<String>? permissions,
    String? password,
    bool? isEmailVerified,
  }) {
    return User(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      role: role ?? this.role,
      creditLimit: creditLimit ?? this.creditLimit,
      currentBalance: currentBalance ?? this.currentBalance,
      syncStatus: syncStatus ?? this.syncStatus,
      isDeleted: isDeleted ?? this.isDeleted,
      permissions: permissions ?? this.permissions,
      password: password ?? this.password,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  bool get isAdmin => role == 'admin';
  bool get isManager => role == 'manager';
  bool get isEmployee => role == 'employee';

  bool hasPermission(String permission) {
    if (isAdmin)
      return true; // Admin has all permissions implicitly (frontend safety)
    return permissions.contains(permission);
  }
}

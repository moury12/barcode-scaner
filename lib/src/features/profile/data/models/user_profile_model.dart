class UserProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String profileImg;
  final String status;
  final DateTime? lastLoginAt;
  final DateTime? createdAt;

  const UserProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.profileImg,
    required this.status,
    this.lastLoginAt,
    this.createdAt,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      role: json['role'] as String? ?? 'customer',
      profileImg: json['profileImg'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.tryParse(json['lastLoginAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImg': profileImg,
      'status': status,
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? role,
    String? profileImg,
    String? status,
    DateTime? lastLoginAt,
    DateTime? createdAt,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profileImg: profileImg ?? this.profileImg,
      status: status ?? this.status,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

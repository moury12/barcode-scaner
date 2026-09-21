class MyMembershipModel {
  final String id;
  final String shopId;
  final String shopName;
  final String contactNumber;
  final String address;
  final String image;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MyMembershipModel({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.contactNumber,
    required this.address,
    required this.image,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory MyMembershipModel.fromJson(Map<String, dynamic> json) {
    String parsedShopId = '';
    if (json['shopId'] is String) {
      parsedShopId = json['shopId'] as String;
    } else if (json['shopId'] is Map) {
      parsedShopId = (json['shopId'] as Map)['_id']?.toString() ?? '';
    }

    return MyMembershipModel(
      id: json['_id'] as String? ?? '',
      shopId: parsedShopId,
      shopName: json['shopName'] as String? ?? json['shop']?['name'] as String? ?? '',
      contactNumber: json['contactNumber'] as String? ?? json['shop']?['contactNumber'] as String? ?? '',
      address: json['address'] as String? ?? json['shop']?['address'] as String? ?? '',
      image: json['image'] as String? ?? json['shop']?['image'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'shopId': shopId,
      'shopName': shopName,
      'contactNumber': contactNumber,
      'address': address,
      'image': image,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  MyMembershipModel copyWith({
    String? id,
    String? shopId,
    String? shopName,
    String? contactNumber,
    String? address,
    String? image,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MyMembershipModel(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      contactNumber: contactNumber ?? this.contactNumber,
      address: address ?? this.address,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

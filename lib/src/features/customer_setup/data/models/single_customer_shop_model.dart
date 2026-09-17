export 'customer_shop_model.dart';

class SingleCustomerShopModel {
  final String id;
  final String name;
  final String image;
  final String contactNumber;
  final String description;
  final String address;
  final String dailyBenefitDescription;
  final String qrCode;
  final int totalActiveCustomers;
  final List<OpeningHourItem> openingHours;
  final bool isJoin;
  final String? membershipStatus;
  final String createdAt;
  final String updatedAt;

  const SingleCustomerShopModel({
    required this.id,
    required this.name,
    required this.image,
    required this.contactNumber,
    required this.description,
    required this.address,
    required this.dailyBenefitDescription,
    required this.qrCode,
    required this.totalActiveCustomers,
    required this.openingHours,
    required this.isJoin,
    this.membershipStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SingleCustomerShopModel.fromJson(Map<String, dynamic> json) {
    final rawHours = json['openingHours'] as List<dynamic>? ?? [];
    return SingleCustomerShopModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      contactNumber: json['contactNumber'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      dailyBenefitDescription: json['dailyBenefitDescription'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      totalActiveCustomers: json['totalActiveCustomers'] as int? ?? 0,
      openingHours: rawHours
          .whereType<Map<String, dynamic>>()
          .map((e) => OpeningHourItem.fromJson(e))
          .toList(),
      isJoin: json['isJoin'] as bool? ?? false,
      membershipStatus: json['membershipStatus'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}

class OpeningHourItem {
  final String id;
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  const OpeningHourItem({
    required this.id,
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory OpeningHourItem.fromJson(Map<String, dynamic> json) {
    return OpeningHourItem(
      id: json['_id'] as String? ?? '',
      day: json['day'] as String? ?? '',
      openTime: json['openTime'] as String? ?? '',
      closeTime: json['closeTime'] as String? ?? '',
      isClosed: json['isClosed'] as bool? ?? false,
    );
  }
}

// Re-export for convenience

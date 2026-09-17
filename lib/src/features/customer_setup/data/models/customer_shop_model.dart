class CustomerShopModel {
  final String id;
  final String name;
  final String image;
  final String contactNumber;
  final String description;
  final String address;
  final String dailyBenefitDescription;
  final String qrCode;
  final String createdAt;
  final String updatedAt;

  const CustomerShopModel({
    required this.id,
    required this.name,
    required this.image,
    required this.contactNumber,
    required this.description,
    required this.address,
    required this.dailyBenefitDescription,
    required this.qrCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CustomerShopModel.fromJson(Map<String, dynamic> json) {
    return CustomerShopModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ?? '',
      contactNumber: json['contactNumber'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      dailyBenefitDescription: json['dailyBenefitDescription'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}

class CustomerShopListMeta {
  final int page;
  final int limit;
  final int totalPages;
  final int total;

  const CustomerShopListMeta({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.total,
  });

  factory CustomerShopListMeta.fromJson(Map<String, dynamic> json) {
    return CustomerShopListMeta(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      totalPages: json['totalPages'] as int? ?? 1,
      total: json['total'] as int? ?? 0,
    );
  }
}

class CustomerShopListResponse {
  final List<CustomerShopModel> shops;
  final CustomerShopListMeta meta;

  const CustomerShopListResponse({
    required this.shops,
    required this.meta,
  });
}

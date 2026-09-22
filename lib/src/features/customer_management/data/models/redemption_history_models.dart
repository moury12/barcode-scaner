class OwnerRedemptionModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerImg;
  final String qrCode;
  final bool isRedeemed;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OwnerRedemptionModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerImg,
    required this.qrCode,
    required this.isRedeemed,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory OwnerRedemptionModel.fromJson(Map<String, dynamic> json) {
    return OwnerRedemptionModel(
      id: json['_id'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      customerEmail: json['customerEmail'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      customerImg: json['customerImg'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      // API returns 'isRedeemed' (not 'isUsed')
      isRedeemed: json['isRedeemed'] as bool? ?? false,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Alias for backward-compat with code that used the old field name.
  bool get isUsed => isRedeemed;
}

class CustomerRedemptionModel {
  final String id;
  final String shopId;
  final String shopName;
  final String contactNumber;
  final String address;
  final String image;
  final String qrCode;
  final bool isRedeemed;
  final DateTime? expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CustomerRedemptionModel({
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.contactNumber,
    required this.address,
    required this.image,
    required this.qrCode,
    required this.isRedeemed,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerRedemptionModel.fromJson(Map<String, dynamic> json) {
    return CustomerRedemptionModel(
      id: json['_id'] as String? ?? '',
      shopId: json['shopId'] as String? ?? '',
      shopName: json['shopName'] as String? ?? '',
      contactNumber: json['contactNumber'] as String? ?? '',
      address: json['address'] as String? ?? '',
      image: json['image'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
      // API returns 'isRedeemed' (not 'isUsed')
      isRedeemed: json['isRedeemed'] as bool? ?? false,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
    );
  }

  /// Alias for backward-compat with code that used the old field name.
  bool get isUsed => isRedeemed;
}

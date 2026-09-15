class OpeningHourModel {
  final String id;
  final String shopId;
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  const OpeningHourModel({
    required this.id,
    required this.shopId,
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory OpeningHourModel.fromJson(Map<String, dynamic> json) {
    return OpeningHourModel(
      id: json['_id'] as String? ?? '',
      shopId: json['shopId'] as String? ?? '',
      day: json['day'] as String? ?? '',
      openTime: json['openTime'] as String? ?? '',
      closeTime: json['closeTime'] as String? ?? '',
      isClosed: json['isClosed'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'shopId': shopId,
        'day': day,
        'openTime': openTime,
        'closeTime': closeTime,
        'isClosed': isClosed,
      };
}

class ShopModel {
  final String id;
  final String name;
  final String? image;
  final String? contactNumber;
  final String? description;
  final String? address;
  final String? qrCode;
  final String status;
  final List<OpeningHourModel> openingHours;

  const ShopModel({
    required this.id,
    required this.name,
    this.image,
    this.contactNumber,
    this.description,
    this.address,
    this.qrCode,
    required this.status,
    this.openingHours = const [],
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    final hoursRaw = json['openingHours'];
    final hours = hoursRaw is List
        ? hoursRaw
            .whereType<Map<String, dynamic>>()
            .map((e) => OpeningHourModel.fromJson(e))
            .toList()
        : <OpeningHourModel>[];

    return ShopModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      image: json['image'] as String?,
      contactNumber: json['contactNumber'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      qrCode: json['qrCode'] as String?,
      status: json['status'] as String? ?? 'pending',
      openingHours: hours,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'image': image,
        'contactNumber': contactNumber,
        'description': description,
        'address': address,
        'qrCode': qrCode,
        'status': status,
        'openingHours': openingHours.map((h) => h.toJson()).toList(),
      };
}

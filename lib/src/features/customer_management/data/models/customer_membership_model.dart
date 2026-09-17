class CustomerMembershipModel {
  final String id;
  final String customerId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerImg;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const CustomerMembershipModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerImg,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerMembershipModel.fromJson(Map<String, dynamic> json) {
    return CustomerMembershipModel(
      id: json['_id'] as String? ?? '',
      customerId: json['customerId'] as String? ?? '',
      customerName: json['customerName'] as String? ?? '',
      customerEmail: json['customerEmail'] as String? ?? '',
      customerPhone: json['customerPhone'] as String? ?? '',
      customerImg: json['customerImg'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
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
      'customerId': customerId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerImg': customerImg,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  CustomerMembershipModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerEmail,
    String? customerPhone,
    String? customerImg,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CustomerMembershipModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerEmail: customerEmail ?? this.customerEmail,
      customerPhone: customerPhone ?? this.customerPhone,
      customerImg: customerImg ?? this.customerImg,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class CustomerMembershipListMeta {
  final int page;
  final int limit;
  final int totalPages;
  final int total;

  const CustomerMembershipListMeta({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.total,
  });

  factory CustomerMembershipListMeta.fromJson(Map<String, dynamic> json) {
    return CustomerMembershipListMeta(
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }
}

class CustomerMembershipListResponse {
  final List<CustomerMembershipModel> data;
  final CustomerMembershipListMeta meta;

  const CustomerMembershipListResponse({
    required this.data,
    required this.meta,
  });
}

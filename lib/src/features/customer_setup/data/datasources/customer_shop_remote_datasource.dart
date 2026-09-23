import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:barcode_scaner/src/core/services/api_service.dart';
import '../models/single_customer_shop_model.dart';

import '../models/my_membership_model.dart';

abstract class CustomerShopRemoteDataSource {
  Future<CustomerShopListResponse> getCustomerShops({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  });
  Future<SingleCustomerShopModel> getSingleCustomerShop(String shopId);
  Future<Map<String, dynamic>> joinShop(String shopId);
  Future<Map<String, dynamic>> joinShopWithQrCode(String qrCode);
  Future<List<MyMembershipModel>> getMyActiveMemberships();
  Future<Map<String, dynamic>> generateQrCode(String shopId);
}

class CustomerShopRemoteDataSourceImpl implements CustomerShopRemoteDataSource {
  final ApiService _api;

  CustomerShopRemoteDataSourceImpl(this._api);

  @override
  Future<CustomerShopListResponse> getCustomerShops({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    final query = <String, dynamic>{'page': page, 'limit': limit};
    if (searchTerm != null && searchTerm.trim().isNotEmpty) {
      query['searchTerm'] = searchTerm.trim();
    }
    final response = await _api.get(
      '/shop/customer-shops',
      queryParameters: query,
    );

    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      final shops = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => CustomerShopModel.fromJson(e))
          .toList();

      final rawMeta = response.data['meta'] as Map<String, dynamic>? ?? {};
      final meta = CustomerShopListMeta.fromJson(rawMeta);

      return CustomerShopListResponse(shops: shops, meta: meta);
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch shops';
    throw Exception(msg);
  }

  @override
  Future<SingleCustomerShopModel> getSingleCustomerShop(String shopId) async {
    final response = await _api.get('/shop/single-customer-shop/$shopId');

    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data == null) throw Exception('No shop data returned');
      return SingleCustomerShopModel.fromJson(data);
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch shop details';
    throw Exception(msg);
  }

  @override
  Future<Map<String, dynamic>> joinShop(String shopId) async {
    final response = await _api.post(
      '/membership/join-shop',
      data: {'shopId': shopId},
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to join shop';
    throw Exception(msg);
  }

  @override
  Future<Map<String, dynamic>> joinShopWithQrCode(String qrCode) async {
    final response = await _api.post(
      '/membership/join-shop-with-qr-code',
      data: {'qrCode': qrCode},
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to join shop';
    throw Exception(msg);
  }

  @override
  Future<List<MyMembershipModel>> getMyActiveMemberships() async {
    final response = await _api.get(
      '/membership/my-memberships',
      queryParameters: {'status': 'active', 'limit': '100'},
    );

    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => MyMembershipModel.fromJson(e))
          .toList();
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch active memberships';
    throw Exception(msg);
  }

  @override
  Future<Map<String, dynamic>> generateQrCode(String shopId) async {
    final response = await _api.post(
      '/redemption/generate-qr-code',
      data: {'shopId': shopId},
    );

    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) return data;
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to generate QR code';
    throw Exception(msg);
  }
}

final customerShopRemoteDataSourceProvider =
    Provider<CustomerShopRemoteDataSource>((ref) {
      final api = ref.watch(apiServiceProvider);
      return CustomerShopRemoteDataSourceImpl(api);
    });

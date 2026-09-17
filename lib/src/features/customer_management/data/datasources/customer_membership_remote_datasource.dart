import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/customer_membership_model.dart';

abstract class CustomerMembershipRemoteDataSource {
  Future<CustomerMembershipListResponse> getMembershipRequests({
    int page = 1,
    int limit = 10,
    String? status,
    String? searchTerm,
  });

  Future<bool> updateMembershipStatus({
    required String membershipId,
    required String status,
  });
}

class CustomerMembershipRemoteDataSourceImpl
    implements CustomerMembershipRemoteDataSource {
  final ApiService _api;

  CustomerMembershipRemoteDataSourceImpl(this._api);

  @override
  Future<CustomerMembershipListResponse> getMembershipRequests({
    int page = 1,
    int limit = 10,
    String? status,
    String? searchTerm,
  }) async {
    final query = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (status != null && status.isNotEmpty) {
      query['status'] = status.toLowerCase();
    }
    if (searchTerm != null && searchTerm.trim().isNotEmpty) {
      query['searchTerm'] = searchTerm.trim();
    }

    final response = await _api.get(
      '/membership/requests',
      queryParameters: query,
    );

    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      final members = rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => CustomerMembershipModel.fromJson(e))
          .toList();

      final rawMeta = response.data['meta'] as Map<String, dynamic>? ?? {};
      final meta = CustomerMembershipListMeta.fromJson(rawMeta);

      return CustomerMembershipListResponse(data: members, meta: meta);
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to retrieve membership requests';
    throw Exception(msg);
  }

  @override
  Future<bool> updateMembershipStatus({
    required String membershipId,
    required String status,
  }) async {
    final response = await _api.patch(
      '/membership/update-status/$membershipId',
      data: {'status': status.toLowerCase()},
    );

    if (response.data != null && response.data['success'] == true) {
      return true;
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to update membership status';
    throw Exception(msg);
  }
}

final customerMembershipRemoteDataSourceProvider =
    Provider<CustomerMembershipRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return CustomerMembershipRemoteDataSourceImpl(api);
});

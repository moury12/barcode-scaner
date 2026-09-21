import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/redemption_history_models.dart';

abstract class RedemptionHistoryRemoteDataSource {
  Future<List<OwnerRedemptionModel>> getOwnerRedemptions({int page = 1, int limit = 10});
  Future<List<CustomerRedemptionModel>> getCustomerRedemptions({int page = 1, int limit = 10, String? searchTerm});
}

class RedemptionHistoryRemoteDataSourceImpl implements RedemptionHistoryRemoteDataSource {
  final ApiService _api;

  RedemptionHistoryRemoteDataSourceImpl(this._api);

  @override
  Future<List<OwnerRedemptionModel>> getOwnerRedemptions({int page = 1, int limit = 10}) async {
    final response = await _api.get(
      '/redemption/owner-redemptions',
      queryParameters: {'page': page, 'limit': limit},
    );

    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => OwnerRedemptionModel.fromJson(e))
          .toList();
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch owner redemptions';
    throw Exception(msg);
  }

  @override
  Future<List<CustomerRedemptionModel>> getCustomerRedemptions({
    int page = 1,
    int limit = 10,
    String? searchTerm,
  }) async {
    final query = <String, dynamic>{'page': page, 'limit': limit};
    if (searchTerm != null && searchTerm.trim().isNotEmpty) {
      query['searchTerm'] = searchTerm.trim();
    }

    final response = await _api.get(
      '/redemption/customer-redemptions',
      queryParameters: query,
    );

    if (response.data != null && response.data['success'] == true) {
      final rawList = response.data['data'] as List<dynamic>? ?? [];
      return rawList
          .whereType<Map<String, dynamic>>()
          .map((e) => CustomerRedemptionModel.fromJson(e))
          .toList();
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch customer redemptions';
    throw Exception(msg);
  }
}

final redemptionHistoryRemoteDataSourceProvider =
    Provider<RedemptionHistoryRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return RedemptionHistoryRemoteDataSourceImpl(api);
});

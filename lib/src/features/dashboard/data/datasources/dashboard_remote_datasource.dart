import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/dashboard_stats_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getOwnerStats();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiService _api;

  DashboardRemoteDataSourceImpl(this._api);

  @override
  Future<DashboardStatsModel> getOwnerStats() async {
    final response = await _api.get('/dashboard/owner-stats');

    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) return DashboardStatsModel.fromJson(data);
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch dashboard stats';
    throw Exception(msg);
  }
}

final dashboardRemoteDataSourceProvider =
    Provider<DashboardRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return DashboardRemoteDataSourceImpl(api);
});

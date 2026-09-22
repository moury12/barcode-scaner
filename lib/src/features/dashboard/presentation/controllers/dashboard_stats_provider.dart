import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/models/dashboard_stats_model.dart';

final dashboardStatsProvider = FutureProvider<DashboardStatsModel>((ref) async {
  final ds = ref.watch(dashboardRemoteDataSourceProvider);
  return ds.getOwnerStats();
});

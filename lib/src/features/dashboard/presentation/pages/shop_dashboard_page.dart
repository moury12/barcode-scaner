import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../controllers/dashboard_stats_provider.dart';

class ShopDashboardPage extends ConsumerWidget {
  const ShopDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(dashboardStatsProvider),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(dashboardStatsProvider),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScanHeroCard(),
              space16H,
              statsAsync.when(
                data: (stats) => Column(
                  children: [
                    DashboardStatCard(
                      title: "Active Customers",
                      value: stats.totalActiveCustomers.toString(),
                    ),
                    space12H,
                    DashboardStatCard(
                      title: "Pending Requests",
                      value: stats.totalPendingRequests.toString(),
                    ),
                    space12H,
                    DashboardStatCard(
                      title: "Today's Redemptions",
                      value: stats.todaysRedemptions.toString(),
                    ),
                  ],
                ),
                loading: () => Column(
                  children: [
                    _StatSkeleton(),
                    space12H,
                    _StatSkeleton(),
                    space12H,
                    _StatSkeleton(),
                  ],
                ),
                error: (e, _) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      space8H,
                      CustomText(
                        e.toString().replaceAll('Exception: ', ''),
                        textAlign: TextAlign.center,
                        color: Colors.red.shade700,
                        variant: TextVariant.bodySmall,
                      ),
                      space8H,
                      TextButton(
                        onPressed: () => ref.invalidate(dashboardStatsProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              space24H,
              const RecentRedemptionsList(),
              space16H,
            ],
          ),
        ),
      ),
    );
  }
}

class _StatSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

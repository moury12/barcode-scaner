class DashboardStatsModel {
  final int totalActiveCustomers;
  final int totalPendingRequests;
  final int todaysRedemptions;

  const DashboardStatsModel({
    required this.totalActiveCustomers,
    required this.totalPendingRequests,
    required this.todaysRedemptions,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      totalActiveCustomers: json['totalActiveCustomers'] as int? ?? 0,
      totalPendingRequests: json['totalPendingRequests'] as int? ?? 0,
      todaysRedemptions: json['todaysRedemptions'] as int? ?? 0,
    );
  }
}

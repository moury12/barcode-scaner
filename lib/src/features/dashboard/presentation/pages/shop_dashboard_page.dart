import '../../../../src_export.dart';

class ShopDashboardPage extends StatelessWidget {
  const ShopDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(AppStaticStrings.appName, variant: TextVariant.titleLarge,),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScanHeroCard(),
            space16H,
            DashboardStatCard(title: "Active Customers", value: "1,248"),
            space12H,
            DashboardStatCard(title: "Pending Requests", value: "12"),
            space12H,
            DashboardStatCard(title: "Today's Redemptions", value: "84"),
            space24H,
            RecentRedemptionsList(),
            space16H,
          ],
        ),
      ),
    );
  }
}

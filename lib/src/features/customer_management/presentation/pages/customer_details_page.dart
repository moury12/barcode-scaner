import '../../../../src_export.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText("Customer Details", variant: TextVariant.titleLarge),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=32')),
            space12H,
            const CustomText("Julianna Vane", variant: TextVariant.headlineMedium, fontWeight: FontWeight.bold),
            const CustomText("Active", color: AppColors.kGreenColor, fontWeight: FontWeight.bold),
            space24H,
            const CustomerInfoCard(
              email: "julianna.v@example.com",
              phone: "+44 7700 900088",
            ),
            space16H,
            const CustomerStatsRow(totalRedemptions: "42", latestRedemption: "Today, 09:45 AM"),
            space24H,
            CustomButton(
              text: "View Redemption History",
              backgroundColor: AppColors.kSetupButtonColor,
              onPressed: () => context.push(AppRoutes.redemptionHistory),
            ),
            space12H,
            CustomButton(
              text: "Deactivate Customer",
              isOutlined: true,
              textColor: Colors.red,
              borderColor: Colors.red.withValues(alpha: 0.2),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

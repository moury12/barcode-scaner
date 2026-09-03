import '../../../../src_export.dart';

class CustomerVerifiedPage extends StatelessWidget {
  const CustomerVerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const CustomText("Customer Verified", variant: TextVariant.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CustomerVerificationCard(
              customerName: "Julianna Vane",
              memberStatus: "Active Member",
              plan: "Daily Brew Pass",
              resetTime: "Midnight",
            ),
            space24H,
            CustomButton(
              text: "Confirm Redemption",
              backgroundColor: const Color(0xFF25160E),
              icon: Icons.check,
              onPressed: () => context.push(AppRoutes.redemptionSuccess),
            ),
            space8H,
            CustomButton(
              text: "Cancel",
              isOutlined: true,
              borderColor: Colors.grey.shade300,
              textColor: AppColors.kTextColor,
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

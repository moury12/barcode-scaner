import '../../../../src_export.dart';

class CustomerRequestPage extends StatelessWidget {
  const CustomerRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText("Activation Request", variant: TextVariant.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
            space12H,
            const CustomText("Marcus Thorne", variant: TextVariant.headlineMedium, fontWeight: FontWeight.bold),
            const CustomText("Pending Approval", color: AppColors.kAccentColor, fontWeight: FontWeight.bold),
            space24H,
            const ActivationBannerCard(customerName: "Marcus Thorne"),
            space16H,
            const CustomerInfoCard(
              email: "marcus.t@example.com",
              phone: "+44 7700 900123",
            ),
            space16H,
            const RequestInfoCard(
              requestDate: "Oct 14, 2023",
              plan: "Daily Brew Pass",
            ),
            space24H,
            CustomButton(
              text: "Activate Customer",
              backgroundColor: AppColors.kSetupButtonColor,
              onPressed: () => context.push(AppRoutes.confirmActivation),
            ),
            space12H,
            CustomButton(
              text: "Decline Request",
              isOutlined: true,
              textColor: Colors.red,
              borderColor: Colors.red.withValues(alpha: 0.2),
              onPressed: () => context.pop(),
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../../src_export.dart';

class ConfirmActivationPage extends StatelessWidget {
  const ConfirmActivationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding24(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFE8F0E8),
                child: Icon(Icons.check_circle_outline, size: 50, color: AppColors.kSetupButtonColor),
              ),
              space24H,
              const CustomText(
                "Customer Activated!",
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              space8H,
              const CustomText(
                "Marcus Thorne is now an active member and can redeem daily drinks at your shop.",
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              const Spacer(),
              CustomButton(
                text: "Back to Customer List",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () => context.go(AppRoutes.mainLayout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

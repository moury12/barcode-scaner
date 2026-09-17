import '../../../../src_export.dart';

class ConfirmActivationPage extends StatelessWidget {
  final String? customerName;

  const ConfirmActivationPage({super.key, this.customerName});

  @override
  Widget build(BuildContext context) {
    final name = customerName != null && customerName!.isNotEmpty ? customerName! : 'Customer';

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
              CustomText(
                "$name is now an active member and can redeem benefits at your shop.",
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              const Spacer(),
              CustomButton(
                text: "Back to Customer List",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

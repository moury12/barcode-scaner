import '../../../../src_export.dart';

class RedemptionStatusPage extends StatelessWidget {
  final bool isSuccess;

  const RedemptionStatusPage({
    super.key,
    required this.isSuccess,
  });

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
              CircleAvatar(
                radius: 40,
                backgroundColor: isSuccess ? const Color(0xFFE8F0E8) : const Color(0xFFFDE8E8),
                child: Icon(
                  isSuccess ? Icons.check : Icons.priority_high,
                  size: 40,
                  color: isSuccess ? AppColors.kSetupButtonColor : Colors.red,
                ),
              ),
              space16H,
              CustomText(
                isSuccess ? "Drink Redeemed\nSuccessfully" : "Code Not Eligible",
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              space8H,
              CustomText(
                isSuccess
                    ? "The redemption has been recorded."
                    : "Unable to process this code. It might be expired or already used.",
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              space24H,
              if (isSuccess)
                const RedemptionDetailsCard(
                  customerName: "Julianna Vane",
                  time: "10:42 AM",
                ),
              const Spacer(),
              CustomButton(
                text: isSuccess ? "Scan Next Customer" : "Try Again",
                backgroundColor: const Color(0xFF25160E),
                onPressed: () => context.pop(),
              ),
              space8H,
              CustomButton(
                text: "Back to Dashboard",
                isOutlined: true,
                borderColor: Colors.grey.shade300,
                textColor: AppColors.kTextColor,
                onPressed: () => context.go(AppRoutes.mainLayout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

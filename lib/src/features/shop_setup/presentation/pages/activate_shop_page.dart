import '../../../../src_export.dart';

class ActivateShopPage extends StatelessWidget {
  const ActivateShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Image.asset(
                AppStaticStrings.onboardingImg1,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Column(
                children: [
                  space16H,
                  const CustomText(
                    AppStaticStrings.activateShopTitle,
                    variant: TextVariant.headlineLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  space8H,
                  const CustomText(
                    "Choose a subscription plan to start managing customers and redemptions.",
                    textAlign: TextAlign.center,
                    color: AppColors.kBrownTextColor,
                  ),
                  space16H,
                  _featureItem(Icons.group_outlined, "Customer Management"),
                  space12H,
                  _featureItem(Icons.qr_code_scanner, "Daily Code Scanning"),
                  space12H,
                  _featureItem(Icons.bar_chart, "Redemption Tracking"),
                  space24H,
                  CustomButton(
                    text: "CHOOSE A PLAN →",
                    backgroundColor: AppColors.kSetupButtonColor,
                    onPressed: () => context.push(AppRoutes.choosePlan),
                  ),
                  space12H,
                  ButtonTapWidget(
                    onTap: () {},
                    child: const CustomText(
                      "Contact Support",
                      color: AppColors.kBrownTextColor,
                      variant: TextVariant.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.kPrimaryColor, size: 20),
          ),
          space12W,
          CustomText(text, variant: TextVariant.bodyMedium, fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}

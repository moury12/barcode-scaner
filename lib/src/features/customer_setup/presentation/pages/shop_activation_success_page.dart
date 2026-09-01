import '../../../../src_export.dart';

class ShopActivationSuccessPage extends StatelessWidget {
  const ShopActivationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.activationSuccessTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.getPadding12(context),
            child: Column(
              spacing: 12,
              children: [
                // Teal/Green circle with white checkmark
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: AppColors.kSetupButtonColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),

                const CustomText(
                  AppStaticStrings.activationSuccess,
                  variant: TextVariant.headlineMedium,
                  fontWeight: FontWeight.bold,
                ),

                const CustomText(
                  "Your account is active and linked to Heritage Cafe.\nYou can now claim your daily drink benefits!",
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                ),

                // Shop Profile Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    spacing: 6,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.storefront,
                          color: AppColors.kPrimaryColor,
                          size: 28,
                        ),
                      ),

                      const Expanded(
                        child: Column(
                          spacing: 4,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              "Heritage Cafe",
                              variant: TextVariant.titleMedium,
                              fontWeight: FontWeight.bold,
                            ),

                            CustomText(
                              "Marylebone, London",
                              variant: TextVariant.bodySmall,
                              color: AppColors.kBrownTextColor,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          spacing: 6,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),

                            const CustomText(
                              "Active",
                              variant: TextVariant.labelMedium,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                space12H,
                CustomButton(
                  text: "Go to Home →",
                  backgroundColor: AppColors.kSetupButtonColor,
                  onPressed: () => context.go(AppRoutes.home),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

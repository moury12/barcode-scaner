import '../../../../src_export.dart';

class DrinkStatusCard extends StatelessWidget {
  final bool isAvailable;
  final VoidCallback onShowCode;

  const DrinkStatusCard({
    super.key,
    required this.isAvailable,
    required this.onShowCode,
  });

  @override
  Widget build(BuildContext context) {
    if (!isAvailable) {
      // Redeemed State - Matches Provided Screenshot Exactly
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              "TODAY'S DRINK",
              variant: TextVariant.labelMedium,
              color: AppColors.kBrownTextColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
            space16H,
            // Stacked Circular Checkmark Avatar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F1),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF162521),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            space16H,
            const CustomText(
              "REDEEMED",
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
              color: AppColors.kTextColor,
              letterSpacing: 0.5,
            ),
            space8H,
            const CustomText(
              "You've already enjoyed today's\ndrink.",
              textAlign: TextAlign.center,
              color: AppColors.kBrownTextColor,
              variant: TextVariant.bodyMedium,
            ),
            space20H,
            // Pill button badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F5F2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    color: AppColors.kBrownTextColor,
                  ),
                  space8W,
                  CustomText(
                    "Available again tomorrow",
                    color: AppColors.kBrownTextColor,
                    variant: TextVariant.bodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Available State
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: const Color(0xFF536148),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "TODAY'S DRINK",
            variant: TextVariant.titleMedium,
            color: Colors.white,
          ),
          space4H,
          const CustomText(
            AppStaticStrings.available,
            variant: TextVariant.headlineMedium,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          space4H,
          const CustomText(
            "Your daily drink is ready to redeem. Show your code to the barista.",
            color: Colors.white70,
            textAlign: TextAlign.left,
            variant: TextVariant.bodyMedium,
          ),
          space12H,
          CustomButton(
            text: AppStaticStrings.showMyCode,
            backgroundColor: Colors.white,
            textColor: const Color(0xFF536148),
            onPressed: onShowCode,
          ),
        ],
      ),
    );
  }
}

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
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFF536148) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isAvailable ? null : Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "TODAY'S DRINK",
            variant: TextVariant.titleMedium,
            color: Colors.white,
          ),
          CustomText(
            isAvailable
                ? AppStaticStrings.available
                : AppStaticStrings.redeemed,
            variant: TextVariant.headlineMedium,
            color: isAvailable ? Colors.white : AppColors.kTextColor,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            "Your daily drink is ready to redeem. Show your code to the barista.",
            color: isAvailable ? Colors.white70 : AppColors.kBrownTextColor,
            textAlign: TextAlign.left,
            variant: TextVariant.bodyMedium,
          ),

          if (isAvailable)
            CustomButton(
              text: AppStaticStrings.showMyCode,
              backgroundColor: Colors.white,
              textColor: const Color(0xFF536148),
              onPressed: onShowCode,
            )
          else
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: AppColors.kBrownTextColor,
                ),
                space8W,
                CustomText(
                  "Available again tomorrow",
                  color: AppColors.kBrownTextColor,
                  variant: TextVariant.bodySmall,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

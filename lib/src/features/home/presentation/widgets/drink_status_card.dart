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
        children: [
          CustomText(
            isAvailable ? AppStaticStrings.available : AppStaticStrings.redeemed,
            variant: TextVariant.headlineMedium,
            color: isAvailable ? Colors.white : AppColors.kTextColor,
            fontWeight: FontWeight.bold,
          ),
          space8H,
          CustomText(
            isAvailable
                ? "Your daily drink is ready to redeem."
                : "You've already enjoyed today's drink.",
            color: isAvailable ? Colors.white70 : AppColors.kBrownTextColor,
            textAlign: TextAlign.center,
          ),
          space16H,
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

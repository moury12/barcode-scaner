import '../../../../src_export.dart';

class ActivationBannerCard extends StatelessWidget {
  final String customerName;

  const ActivationBannerCard({
    super.key,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: AppColors.kYellowColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.kYellowColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.kYellowColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add, color: Colors.black, size: 24),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText("Pending Activation", fontWeight: FontWeight.bold, color: AppColors.kAccentColor),
                space2H,
                CustomText("$customerName is requesting membership approval.", variant: TextVariant.bodySmall, color: AppColors.kBrownTextColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

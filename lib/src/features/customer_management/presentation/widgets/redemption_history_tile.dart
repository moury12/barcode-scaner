import '../../../../src_export.dart';

class RedemptionHistoryTile extends StatelessWidget {
  final String customerName;
  final String drinkName;
  final String timestamp;
  final String imageUrl;

  const RedemptionHistoryTile({
    super.key,
    required this.customerName,
    required this.drinkName,
    required this.timestamp,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(customerName, fontWeight: FontWeight.bold),
                space2H,
                CustomText(drinkName, variant: TextVariant.bodySmall, color: AppColors.kBrownTextColor),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.kGreenColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const CustomText("Redeemed", fontSize: 10, color: AppColors.kGreenColor, fontWeight: FontWeight.bold),
              ),
              space4H,
              CustomText(timestamp, variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
            ],
          ),
        ],
      ),
    );
  }
}

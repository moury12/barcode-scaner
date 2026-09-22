import '../../../../src_export.dart';

class RecentRedemptionTile extends StatelessWidget {
  final String nameInitials;
  final String customerName;
  final String drinkName;
  final String timeAgo;
  final String img;

  const RecentRedemptionTile({
    super.key,
    required this.nameInitials,
    required this.customerName,
    required this.drinkName,
    required this.timeAgo,
    required this.img,
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
          img.isEmpty
              ? CircleAvatar(
                  backgroundColor: const Color(0xFFF1F1F1),
                  child: CustomText(
                    nameInitials,
                    variant: TextVariant.labelMedium,
                    color: AppColors.kTextColor, 
                    fontWeight: FontWeight.bold,
                  ),
                )
              : CircleAvatar(backgroundImage: NetworkImage(img)),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  customerName,
                  variant: TextVariant.titleSmall,
                  fontWeight: FontWeight.bold,
                ),
                space2H,
                CustomText(
                  drinkName,
                  variant: TextVariant.bodySmall,
                  color: AppColors.kBrownTextColor,
                ),
              ],
            ),
          ),
          CustomText(
            timeAgo,
            variant: TextVariant.labelSmall,
            color: AppColors.kBrownTextColor,
          ),
        ],
      ),
    );
  }
}

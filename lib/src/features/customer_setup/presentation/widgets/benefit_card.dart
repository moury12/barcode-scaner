import '../../../../src_export.dart';

class BenefitCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const BenefitCard({
    super.key,
    this.title = "Daily Drink Benefit",
    this.description =
        "Get 1 complimentary hot or cold drink every single day when active.",
    this.icon = Icons.card_giftcard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.kYellowColor.withValues(
            alpha: 0.4,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.kYellowColor.withValues(
                alpha: 0.2,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.kAccentColor,
              size: 24,
            ),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  variant: TextVariant.titleSmall,
                  fontWeight: FontWeight.bold,
                ),
                space2H,
                CustomText(
                  description,
                  variant: TextVariant.bodySmall,
                  color: AppColors.kBrownTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

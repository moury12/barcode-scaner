import '../../../../src_export.dart';

class RecentRedemptionsList extends StatelessWidget {
  const RecentRedemptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              "Recent Redemptions",
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            ButtonTapWidget(
              onTap: () {},
              child: const CustomText(
                "View All",
                variant: TextVariant.labelSmall,
                color: AppColors.kAccentColor,
              ),
            ),
          ],
        ),
        space12H,
        const RecentRedemptionTile(
          nameInitials: "JV",
          customerName: "Julianna V.",
          drinkName: "Oat Milk Latte",
          timeAgo: "5m ago",
        ),
        space8H,
        const RecentRedemptionTile(
          nameInitials: "MK",
          customerName: "Marcus K.",
          drinkName: "Cortado",
          timeAgo: "12m ago",
        ),
        space8H,
        const RecentRedemptionTile(
          nameInitials: "SL",
          customerName: "Sarah L.",
          drinkName: "Iced Americano",
          timeAgo: "28m ago",
        ),
      ],
    );
  }
}

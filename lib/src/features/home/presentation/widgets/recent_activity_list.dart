import '../../../../src_export.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: const CustomText(
                "RECENT ACTIVITY",
                variant: TextVariant.labelSmall,
                fontWeight: FontWeight.bold,
                color: AppColors.kBrownTextColor,
              ),
            ),
            ButtonTapWidget(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomText(
                  "View All",
                  fontSize: 10,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        space8H,
        Container(
          padding: AppPadding.getPadding12(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: const Column(
            children: [
              _ActivityTile(
                shopName: "Coffee House Zürich",
                timestamp: "Aug 29, 10:32 AM",
              ),
              Divider(height: 16),
              _ActivityTile(
                shopName: "Coffee House Zürich",
                timestamp: "Aug 28, 08:15 AM",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String shopName;
  final String timestamp;

  const _ActivityTile({required this.shopName, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFF1F1F1),
          child: Icon(Icons.coffee, size: 18, color: AppColors.kTextColor),
        ),
        space12W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(shopName, fontWeight: FontWeight.bold),
              CustomText(
                timestamp,
                variant: TextVariant.bodySmall,
                color: AppColors.kBrownTextColor,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0E8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const CustomText(
            "Redeemed",
            fontSize: 10,
            color: Color(0xFF536148),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

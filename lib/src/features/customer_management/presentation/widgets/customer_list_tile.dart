import '../../../../src_export.dart';

class CustomerListTile extends StatelessWidget {
  final String name;
  final String joinDate;
  final String status;
  final VoidCallback onTap;

  const CustomerListTile({
    super.key,
    required this.name,
    required this.joinDate,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status.toLowerCase() == 'pending';
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            space12W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(name, fontWeight: FontWeight.bold),
                  CustomText("Joined $joinDate", variant: TextVariant.bodySmall, color: AppColors.kBrownTextColor),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isPending ? AppColors.kYellowColor.withValues(alpha: 0.1) : AppColors.kGreenColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                status,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isPending ? AppColors.kAccentColor : AppColors.kGreenColor,
              ),
            ),
            space8W,
            const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

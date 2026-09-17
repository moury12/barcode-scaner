import '../../../../src_export.dart';

class CustomerListTile extends StatelessWidget {
  final String name;
  final String joinDate;
  final String status;
  final String? imageUrl;
  final VoidCallback onTap;

  const CustomerListTile({
    super.key,
    required this.name,
    required this.joinDate,
    required this.status,
    this.imageUrl,
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.kGreenColor;
      case 'pending':
        return AppColors.kAccentColor;
      case 'paused':
        return Colors.blueGrey;
      case 'rejected':
        return Colors.red;
      default:
        return AppColors.kGreenColor;
    }
  }

  Color _getStatusBgColor() {
    return _getStatusColor().withValues(alpha: 0.12);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final statusBgColor = _getStatusBgColor();

    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                  ? NetworkImage(imageUrl!)
                  : null,
              child: (imageUrl == null || imageUrl!.isEmpty)
                  ? const Icon(Icons.person, color: Colors.grey, size: 22)
                  : null,
            ),
            space12W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    name.isNotEmpty ? name : 'Unnamed Customer',
                    fontWeight: FontWeight.bold,
                  ),
                  space2H,
                  CustomText(
                    joinDate.isNotEmpty ? joinDate : 'No date',
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomText(
                status.toUpperCase(),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: statusColor,
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

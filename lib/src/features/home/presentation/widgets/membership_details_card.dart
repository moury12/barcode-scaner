import '../../../../src_export.dart';

class MembershipDetailsCard extends StatelessWidget {
  final MyMembershipModel? membership;

  const MembershipDetailsCard({
    super.key,
    this.membership,
  });

  @override
  Widget build(BuildContext context) {
    final shopName = membership?.shopName.isNotEmpty == true
        ? membership!.shopName
        : "Coffee House Zürich";
    final status = membership?.status.isNotEmpty == true
        ? membership!.status[0].toUpperCase() + membership!.status.substring(1)
        : "Active";
    final address = membership?.address ?? "";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "MEMBERSHIP DETAILS",
          variant: TextVariant.labelSmall,
          fontWeight: FontWeight.bold,
          color: AppColors.kBrownTextColor,
        ),
        space8H,
        Container(
          padding: AppPadding.getPadding16(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(
            children: [
              _DetailRow(label: "Home Shop", value: shopName),
              if (address.isNotEmpty) ...[
                const Divider(height: 24),
                _DetailRow(label: "Address", value: address),
              ],
              const Divider(height: 24),
              _DetailRow(label: "Status", value: status, isStatus: true),
              const Divider(height: 24),
              const _DetailRow(label: "Daily Benefit", value: "1 Handcrafted Drink"),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  final bool isStatus;
  const _DetailRow({
    required this.label,
    required this.value,
    this.isStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          color: AppColors.kBrownTextColor,
          variant: TextVariant.bodySmall,
        ),
        Row(
          children: [
            if (isStatus) ...[
              const CircleAvatar(radius: 4, backgroundColor: Colors.green),
              space8W,
            ],
            CustomText(
              value,
              fontWeight: FontWeight.bold,
              variant: TextVariant.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}

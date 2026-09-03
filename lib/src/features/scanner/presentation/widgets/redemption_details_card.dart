import '../../../../src_export.dart';

class RedemptionDetailsCard extends StatelessWidget {
  final String customerName;
  final String time;

  const RedemptionDetailsCard({
    super.key,
    required this.customerName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText("CUSTOMER", variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
              CustomText(customerName, variant: TextVariant.bodyMedium, fontWeight: FontWeight.bold),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText("REDEMPTION TIME", variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
              CustomText(time, variant: TextVariant.bodyMedium, fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }
}

import '../../../../src_export.dart';

class RedemptionInfoTable extends StatelessWidget {
  const RedemptionInfoTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _InfoRow(label: "Shop", value: "Coffee House Zürich"),
          const Divider(height: 32, thickness: 0.5),
          const _InfoRow(label: "Date", value: "August 27, 2024"),
          const Divider(height: 32, thickness: 0.5),
          const _InfoRow(label: "Time", value: "08:30 AM"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          ),
          const CustomText(
            "Daily benefit",
            variant: TextVariant.labelSmall,
            color: AppColors.kBrownTextColor,
          ),
          space4H,
          const CustomText(
            "1 Handcrafted Drink",
            variant: TextVariant.titleLarge,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(label, color: AppColors.kBrownTextColor),
        CustomText(value, fontWeight: FontWeight.bold),
      ],
    );
  }
}

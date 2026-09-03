import '../../../../src_export.dart';

class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;

  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title,
            variant: TextVariant.labelSmall,
            color: AppColors.kBrownTextColor,
          ),
          space4H,
          CustomText(
            value,
            variant: TextVariant.displaySmall,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}

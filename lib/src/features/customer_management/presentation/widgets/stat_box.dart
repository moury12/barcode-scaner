import '../../../../src_export.dart';

class StatBox extends StatelessWidget {
  final String label;
  final String value;

  const StatBox({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
          space4H,
          CustomText(value, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}

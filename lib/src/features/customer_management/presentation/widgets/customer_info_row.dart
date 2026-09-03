import '../../../../src_export.dart';

class CustomerInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CustomerInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        space12W,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(label, variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
            CustomText(value, fontWeight: FontWeight.bold),
          ],
        ),
      ],
    );
  }
}

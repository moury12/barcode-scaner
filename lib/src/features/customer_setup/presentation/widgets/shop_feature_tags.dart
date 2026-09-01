import '../../../../src_export.dart';

class TagCapsule extends StatelessWidget {
  final String label;

  const TagCapsule({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        label,
        variant: TextVariant.bodySmall,
        fontWeight: FontWeight.w500,
        color: AppColors.kTextColor,
      ),
    );
  }
}

class ShopFeatureTags extends StatelessWidget {
  final List<String> tags;

  const ShopFeatureTags({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) => TagCapsule(label: tag)).toList(),
    );
  }
}

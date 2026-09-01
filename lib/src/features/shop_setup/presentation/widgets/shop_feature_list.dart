import '../../../../src_export.dart';

class ShopFeatureList extends StatelessWidget {
  const ShopFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          _FeatureItem(
            icon: Icons.group_outlined,
            label: "Customer Management",
            isLast: false,
          ),
          Divider(
            height: 1,
            indent: 60,
            endIndent: 20,
            color: Color(0xFFF1F1F1),
          ),
          _FeatureItem(
            icon: Icons.qr_code_scanner,
            label: "Daily Code Scanning",
            isLast: false,
          ),
          Divider(
            height: 1,
            indent: 60,
            endIndent: 20,
            color: Color(0xFFF1F1F1),
          ),
          _FeatureItem(
            icon: Icons.bar_chart_outlined,
            label: "Redemption Tracking",
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isLast;

  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F1F1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.kPrimaryColor, size: 22),
          ),
          space16W,
          CustomText(
            label,
            variant: TextVariant.bodyLarge,
            fontWeight: FontWeight.w500,
            color: AppColors.kTextColor,
          ),
        ],
      ),
    );
  }
}

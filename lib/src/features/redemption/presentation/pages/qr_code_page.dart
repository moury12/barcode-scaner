import '../../../../src_export.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "My Daily Code",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding24(context),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding24(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CustomText(
                    "John Doe",
                    variant: TextVariant.headlineSmall,
                    fontWeight: FontWeight.bold,
                  ),
                  const CustomText(
                    "ID: HH-8293-102",
                    color: AppColors.kBrownTextColor,
                  ),
                  space16H,
                  _validTodayBadge(),
                  space24H,
                  // QR Frame
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.qr_code_2,
                      size: 180,
                      color: AppColors.kTextColor,
                    ),
                  ),
                  space24H,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(icon: Icons.coffee, label: "1 Drink / Day"),
                      _StatItem(
                        icon: Icons.timer_outlined,
                        label: "Until Midnight",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            const CustomText(
              "This code is generated securely for your account.",
              color: AppColors.kBrownTextColor,
              variant: TextVariant.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _validTodayBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF5E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const CustomText(
        "VALID TODAY",
        fontSize: 10,
        color: Color(0xFFB37D4E),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF536148)),
        space4H,
        CustomText(
          label,
          variant: TextVariant.labelSmall,
          color: AppColors.kBrownTextColor,
        ),
      ],
    );
  }
}

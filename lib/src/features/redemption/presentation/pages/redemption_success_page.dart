import '../../../../src_export.dart';

class RedemptionSuccessPage extends StatelessWidget {
  const RedemptionSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.getPadding24(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE8F0E8),
              child: Icon(Icons.check_circle, size: 50, color: Color(0xFF536148)),
            ),
            space24H,
            const CustomText(
              AppStaticStrings.drinkRedeemed,
              variant: TextVariant.displaySmall,
              fontWeight: FontWeight.bold,
            ),
            const CustomText(
              "Enjoy your drink!",
              color: AppColors.kBrownTextColor,
            ),
            space24H,
            _infoTable(context),
            space24H,
            CustomButton(
              text: AppStaticStrings.backToHome,
              backgroundColor: const Color(0xFF536148),
              onPressed: () => context.go(AppRoutes.mainLayout),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTable(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: const Column(
        children: [
          _InfoRow(label: "Shop", value: "Coffee House Zürich"),
          Divider(height: 24),
          _InfoRow(label: "Date", value: "August 27, 2024"),
          Divider(height: 24),
          _InfoRow(label: "Time", value: "08:30 AM"),
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

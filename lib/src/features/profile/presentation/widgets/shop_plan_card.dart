import '../../../../src_export.dart';

class ShopPlanCard extends StatelessWidget {
  const ShopPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText("SUBSCRIPTION STATUS", variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
          space4H,
          CustomText("Premium Plan", variant: TextVariant.titleLarge, fontWeight: FontWeight.bold),
          space4H,
          CustomText("• Active", color: AppColors.kGreenColor, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}

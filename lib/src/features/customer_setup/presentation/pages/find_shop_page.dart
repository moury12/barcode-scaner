import '../../../../src_export.dart';

class FindShopPage extends StatelessWidget {
  const FindShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space16H,
              const Center(
                child: CustomText(
                  AppStaticStrings.findYourShop,
                  variant: TextVariant.displaySmall,
                  fontWeight: FontWeight.bold,
                ),
              ),
              space8H,
              const CustomText(
                AppStaticStrings.findYourShopDesc,
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              const CustomTextField(
                hintText: "Search by name or location",
                prefixIcon: Icon(Icons.search, size: 20),
              ),
              space16H,
              Expanded(
                child: ListView(
                  children: [
                    _shopTile(context, "Heritage Cafe", "Marylebone, London", true),
                    space12H,
                    _shopTile(context, "The Hearth", "Soho, London", true),
                    space12H,
                    _shopTile(context, "Daily Grind", "Covent Garden, London", false),
                  ],
                ),
              ),
              space12H,
              const Center(
                child: CustomText(
                  "Have a shop code?",
                  color: AppColors.kBrownTextColor,
                ),
              ),
              space12H,
              CustomButton(
                text: AppStaticStrings.scanShopQr,
                backgroundColor: AppColors.kSetupButtonColor,
                icon: Icons.qr_code_scanner,
                onPressed: () => context.push(AppRoutes.scanShopQr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopTile(
    BuildContext context,
    String title,
    String loc,
    bool isParticipating,
  ) {
    return ButtonTapWidget(
      onTap: () => context.push(AppRoutes.shopDetails),
      radius: 12,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.storefront,
                color: AppColors.kPrimaryColor,
              ),
            ),
            space12W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(title, fontWeight: FontWeight.bold),
                      space8W,
                      _badge(isParticipating),
                    ],
                  ),
                  space2H,
                  CustomText(
                    loc,
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _badge(bool participating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: participating
            ? AppColors.kYellowColor.withValues(alpha: 0.15)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: CustomText(
        participating ? "PARTICIPATING" : "COMING SOON",
        fontSize: 8,
        color: participating ? AppColors.kAccentColor : Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import '../../../../src_export.dart';

class ActivateShopPage extends StatelessWidget {
  const ActivateShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Image with Rounded Bottom
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                'assets/images/active_ur_shope_img.png',
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: AppPadding.getPadding24(context),
              child: Column(
                children: [
                  // 2. Title and Description
                  const CustomText(
                    AppStaticStrings.activateShopTitle,
                    variant: TextVariant.displaySmall,
                    fontWeight: FontWeight.bold,
                  ),
                  space12H,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: CustomText(
                      "Choose a subscription plan to start managing customers and daily drink redemptions.",
                      textAlign: TextAlign.center,
                      color: AppColors.kBrownTextColor,
                      variant: TextVariant.bodyMedium,
                      height: 1.5,
                    ),
                  ),
                  space24H,

                  // 3. Feature Card List (Custom Widget)
                  const ShopFeatureList(),
                  space24H,

                  // 4. Primary Button
                  CustomButton(
                    text: "CHOOSE A PLAN →",
                    backgroundColor: const Color(0xFF536148), // Moss Green from UI
                    onPressed: () => context.push(AppRoutes.choosePlan),
                  ),
                  space16H,

                  // 5. Contact Support Link
                  ButtonTapWidget(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        "Contact Support",
                        color: Color(0xFF536148),
                        fontWeight: FontWeight.w600,
                        variant: TextVariant.bodyMedium,
                      ),
                    ),
                  ),
                  space16H,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

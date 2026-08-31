import '../../../../src_export.dart';

class ShopDetailsSetupPage extends StatelessWidget {
  const ShopDetailsSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CustomText(
              AppStaticStrings.setupYourShop,
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
            ),
            space8H,
            const CustomText(
              "Complete these details to establish your business presence.",
              textAlign: TextAlign.center,
              color: AppColors.kBrownTextColor,
            ),
            space16H,
            const CustomTextField(
              title: "Shop Name",
              hintText: "e.g. Heritage & Hearth",
            ),
            space12H,
            _logoUploader(),
            space12H,
            const CustomTextField(
              title: "Shop Address",
              hintText: "Street address, City, Postcode",
            ),
            space12H,
            const CustomTextField(
              title: "Contact Number",
              hintText: "+1 (555) 000-0000",
              keyboardType: TextInputType.phone,
            ),
            space12H,
            const CustomTextField(
              title: "Description",
              hintText: "Tell customers about your shop...",
              maxLines: 4,
            ),
            space24H,
            CustomButton(
              text: "Complete Setup →",
              backgroundColor: AppColors.kSetupButtonColor,
              onPressed: () => context.go(AppRoutes.home),
            ),
            space16H,
          ],
        ),
      ),
    );
  }

  Widget _logoUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText("Shop Logo", fontWeight: FontWeight.bold),
        space8H,
        Container(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade400,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: Colors.grey,
              ),
              space8H,
              CustomText(
                "Upload Shop Logo",
                variant: TextVariant.labelMedium,
                fontWeight: FontWeight.w600,
              ),
              space2H,
              CustomText(
                "PNG, JPG up to 5MB",
                variant: TextVariant.bodySmall,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

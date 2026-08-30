import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

/*
// ─── Step 1: Personal & Contact Info ───────────────────────────────────────
class Step1PersonalInfo extends StatelessWidget {
  const Step1PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomText(
          AppStaticStrings.becomeSeller,
          variant: TextVariant.headlineMedium,
        ),
        space8H,
        const CustomText(
          AppStaticStrings.sellerSub,
          textAlign: TextAlign.center,
          color: AppColors.kGreyTextColor,
        ),
        space8H,
        Container(
          padding: AppPadding.getPadding12(context),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kBorderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                AppStaticStrings.personalContactInfo,
                variant: TextVariant.titleMedium,
              ),
              space8H,
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      title: AppStaticStrings.firstName,
                      hintText: 'First Name',
                    ),
                  ),
                  space12W,
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Last Name',
                      title: AppStaticStrings.lastName,
                    ),
                  ),
                ],
              ),
              space8H,
              const CustomTextField(
                title: AppStaticStrings.contactNumber,
                hintText: 'eg, 01234566',
              ),
              space8H,
              const CustomTextField(
                title: AppStaticStrings.address,
                hintText: 'Enter state name',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Step 2: Identity Verification ─────────────────────────────────────────
class Step2Identity extends ConsumerWidget {
  const Step2Identity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          AppStaticStrings.identityVerification,
          variant: TextVariant.titleLarge,
        ),
        space8H,
        const CustomTextField(
          title: AppStaticStrings.idDocumentType,
          hintText: 'National Id',
        ),
        space8H,
        SellerFilePickerBox(
          title: AppStaticStrings.uploadFront,
          asset: AppAssets.camera,
          onPicked: (p) => ref.read(idFrontProvider.notifier).state = p,
        ),
        space8H,
        SellerFilePickerBox(
          title: AppStaticStrings.uploadBack,
          asset: AppAssets.camera,
          onPicked: (p) => ref.read(idBackProvider.notifier).state = p,
        ),
      ],
    );
  }
}

// ─── Step 3: Store & Product Profile ───────────────────────────────────────
class Step3StoreProfile extends ConsumerWidget {
  const Step3StoreProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          AppStaticStrings.storeProductProfile,
          variant: TextVariant.titleLarge,
        ),
        space8H,
        const CustomTextField(
          title: 'Store Name',
          hintText: 'e,g Sneaker head',
        ),
        space8H,
        const CustomTextField(
          title: AppStaticStrings.storeDescription,
          hintText: 'Tell us about your shop',
          maxLines: 4,
        ),
        space8H,
        const CustomText(
          AppStaticStrings.primaryCategory,
          variant: TextVariant.titleMedium,
        ),
        space8H,
        const SellerCategoryCheck(label: 'Sneaker'),
        const SellerCategoryCheck(label: 'Shoe'),
        const SellerCategoryCheck(label: 'Bag'),
        space8H,
        Row(
          children: [
            const Icon(
              Icons.check_box_outline_blank,
              color: AppColors.kGreyTextColor,
              size: 20,
            ),
            space8W,
            const Expanded(
              child: CustomText(
                AppStaticStrings.sellerAgreement,
                fontSize: 10,
                color: AppColors.kGreyTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── File Picker Box ────────────────────────────────────────────────────────
class SellerFilePickerBox extends StatelessWidget {
  const SellerFilePickerBox({
    super.key,
    required this.title,
    required this.asset,
    required this.onPicked,
  });
  final String title, asset;
  final Function(String) onPicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, variant: TextVariant.titleSmall),
        space4H,
        ButtonTapWidget(
          onTap: () async {
            final file = await AppImagePicker.pickImage(context);
            if (file != null) onPicked(file.path);
          },
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.kBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  asset,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kGreyTextColor,
                    BlendMode.srcIn,
                  ),
                ),
                space8H,
                CustomText('Upload $title', color: AppColors.kGreyTextColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Category Checkbox ──────────────────────────────────────────────────────
class SellerCategoryCheck extends ConsumerWidget {
  const SellerCategoryCheck({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(sellerCategoriesProvider).contains(label);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ButtonTapWidget(
        onTap: () {
          final list = List<String>.from(ref.read(sellerCategoriesProvider));
          if (selected) {
            list.remove(label);
          } else {
            list.add(label);
          }
          ref.read(sellerCategoriesProvider.notifier).state = list;
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kBorderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.check_box : Icons.check_box_outline_blank,
                color: selected
                    ? AppColors.kTextColor
                    : AppColors.kGreyTextColor,
                size: 20,
              ),
              space8W,
              CustomText(label),
            ],
          ),
        ),
      ),
    );
  }
}
*/


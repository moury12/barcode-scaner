
/*
class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding8(context),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kBorderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CustomNetworkImage(
            imageUrl: 'https://i.pravatar.cc/150?u=nm',
            height: 60,
            width: 60,
            boxShape: BoxShape.circle,
            border: Border.all(color: AppColors.kAccentColor),
          ),
          space12W,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText('Nm Sujon', variant: TextVariant.titleLarge),
                CustomText('sujon@gmail.com', color: AppColors.kGreyTextColor),
              ],
            ),
          ),
          ButtonTapWidget(
            onTap: () => context.push(AppRoutes.editProfile),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.edit,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.kAccentColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  space4W,
                  const CustomText(
                    'Edit Profile',
                    color: AppColors.kAccentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SellerPromoCard extends StatelessWidget {
  const SellerPromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kAccentColor.withValues(alpha: 0.2),
            AppColors.kBackgroundColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.kPrimaryColor, width: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const CustomText(
            AppStaticStrings.startSellingTitle,
            variant: TextVariant.headlineSmall,
          ),
          space8H,
          const CustomText(
            AppStaticStrings.startSellingSub,
            textAlign: TextAlign.center,
            color: AppColors.kGreyTextColor,
          ),
          space8H,
          CustomButton(
            text: AppStaticStrings.applyNow,
            onPressed: () => context.push(AppRoutes.becomeSeller),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.badgeCount,
    this.textColor,
    this.showChevron = true,
  });
  final String title, icon;
  final VoidCallback onTap;
  final int? badgeCount;
  final Color? textColor;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.kBorderColor, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 20,
              colorFilter: ColorFilter.mode(
                textColor ?? AppColors.kTextColor,
                BlendMode.srcIn,
              ),
            ),
            space12W,
            Expanded(
              child: CustomText(
                title,
                color: textColor,
                variant: TextVariant.bodyLarge,
              ),
            ),
            if (badgeCount != null) ...[
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.kRedColor,
                child: CustomText('$badgeCount', fontSize: 10),
              ),
              space12W,
            ],
            if (showChevron)
              const Icon(Icons.chevron_right, color: AppColors.kGreyTextColor),
          ],
        ),
      ),
    );
  }
}

class EditAvatarWidget extends StatelessWidget {
  const EditAvatarWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonTapWidget(
        onTap: () => AppImagePicker.pickImage(context),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            const CustomNetworkImage(
              imageUrl: 'https://i.pravatar.cc/150?u=nm',
              height: 100,
              width: 100,
              radius: 50,
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.kBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppAssets.edit,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.kAccentColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


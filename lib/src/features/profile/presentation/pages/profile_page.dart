import '../../../../src_export.dart';

/*
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.myProfile)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileInfoCard(),
            // space16H,
            const SellerPromoCard(),
            // space24H,
            const CustomText(
              AppStaticStrings.myPurchases,
              variant: TextVariant.titleLarge,
            ),
            // space8H,
            ProfileMenuItem(
              title: AppStaticStrings.activeOrders,
              icon: AppAssets.shoppingBag,
              badgeCount: 1,
              onTap: () => context.push(AppRoutes.activeOrders),
            ),
            ProfileMenuItem(
              title: AppStaticStrings.ordersReviews,
              icon: AppAssets.history,
              onTap: () => context.push(AppRoutes.orderHistory),
            ),
            // space16H,
            const CustomText(
              AppStaticStrings.settings,
              variant: TextVariant.titleLarge,
            ),
            // space8H,
            ProfileMenuItem(
              title: AppStaticStrings.address,
              icon: AppAssets.location,
              onTap: () => context.push(AppRoutes.selectAddress),
            ),
            ProfileMenuItem(
              title: AppStaticStrings.changePassword,
              icon: AppAssets.lock,
              onTap: () => context.push(AppRoutes.changePassword),
            ),
            ProfileMenuItem(
              title: AppStaticStrings.helpSupport,
              icon: AppAssets.support24,
              onTap: () => context.push(AppRoutes.support),
            ),
            // space16H,
            const CustomText(
              AppStaticStrings.legal,
              variant: TextVariant.titleLarge,
            ),
            // space8H,
            ProfileMenuItem(
              title: AppStaticStrings.privacyPolicy,
              icon: AppAssets.policyIcon,
              onTap: () => context.push(AppRoutes.privacyPolicy),
            ),
            ProfileMenuItem(
              title: AppStaticStrings.termsCondition,
              icon: AppAssets.termsIcon,
              onTap: () => context.push(AppRoutes.termsCondition),
            ),
            // space24H,
            ProfileMenuItem(
              title: AppStaticStrings.logOut,
              icon: AppAssets.logout,
              textColor: AppColors.kRedColor,
              showChevron: false,
              onTap: () {
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/


import '../../../../src_export.dart';

class ShopProfileTab extends StatelessWidget {
  const ShopProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomText(AppStaticStrings.appName, variant: TextVariant.titleLarge)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CustomText("Profile", variant: TextVariant.headlineMedium, fontWeight: FontWeight.bold),
            space16H,
            const ShopPlanCard(),
            space16H,
            const ProfileMenuItem(icon: Icons.storefront, title: "Shop Profile"),
            ProfileMenuItem(
              icon: Icons.history,
              title: "Redemption History",
              onTap: () => context.push(AppRoutes.redemptionHistory),
            ),
            space16H,
            const ProfileMenuItem(icon: Icons.credit_card, title: "Current Plan"),
            space16H,
            const ProfileMenuItem(icon: Icons.help_outline, title: "Help & Support"),
            const ProfileMenuItem(icon: Icons.privacy_tip_outlined, title: "Terms & Privacy"),
            space24H,
            ProfileMenuItem(
              icon: Icons.logout,
              title: "Log Out",
              isDestructive: true,
              onTap: () => context.go(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}

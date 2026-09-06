import '../../../../src_export.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Profile", variant: TextVariant.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            space16H,
            // Circular Avatar Profile Header
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFF1F1F1),
              child: Icon(
                Icons.person_outline,
                size: 40,
                color: AppColors.kTextColor,
              ),
            ),
            space12H,
            const CustomText(
              "John Doe",
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            const CustomText(
              "john.doe@example.com",
              color: AppColors.kBrownTextColor,
              variant: TextVariant.bodyMedium,
            ),
            space24H,

            // ACCOUNT Group
            _buildGroupHeader("ACCOUNT"),
            space8H,
            _buildProfileCard([
              _buildMenuItem(
                icon: Icons.person_outline,
                title: "Personal Details",
                onTap: () => context.push(AppRoutes.personalInfo),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.notifications_none,
                title: "Notifications",
                onTap: () => context.push(AppRoutes.notification),
              ),
            ]),
            space16H,

            // MEMBERSHIP Group
            _buildGroupHeader("MEMBERSHIP"),
            space8H,
            _buildProfileCard([
              // _buildMenuItem(
              //   icon: Icons.storefront_outlined,
              //   title: "Change Home Shop",
              //   onTap: () => context.push(AppRoutes.findShop),
              // ),
              // const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.card_membership_outlined,
                title: "Subscription Details",
                onTap: () {},
              ),
            ]),
            space16H,

            // SUPPORT Group
            _buildGroupHeader("SUPPORT"),
            space8H,
            _buildProfileCard([
              _buildMenuItem(
                icon: Icons.help_outline,
                title: "Help & Support",
                onTap: () => context.push(AppRoutes.helpSupport),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: "Terms & Privacy Policy",
                onTap: () {},
              ),
            ]),
            space24H,

            // Logout Button
            ButtonTapWidget(
              onTap: () => context.go(AppRoutes.login),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: const Center(
                  child: CustomText(
                    "Log Out",
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    variant: TextVariant.bodyMedium,
                  ),
                ),
              ),
            ),
            space24H,
          ],
        ),
      ),
    );
  }

  Widget _buildGroupHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomText(
        title,
        variant: TextVariant.labelSmall,
        fontWeight: FontWeight.bold,
        color: AppColors.kBrownTextColor,
      ),
    );
  }

  Widget _buildProfileCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.kTextColor),
            space16W,
            Expanded(
              child: CustomText(
                title,
                variant: TextVariant.bodyMedium,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.kBrownTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

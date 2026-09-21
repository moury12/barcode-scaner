import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    final success = await ref
        .read(profileActionControllerProvider.notifier)
        .logout();

    if (!context.mounted) return;
    final state = ref.read(profileActionControllerProvider);

    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'User logged out successfully',
        isError: false,
      );
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Logout failed',
        isError: true,
      );
    }
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileActionState = ref.watch(profileActionControllerProvider);
    final userProfileState = ref.watch(userProfileProvider);
    final user = userProfileState.profile;

    final userName = user?.fullName.isNotEmpty == true
        ? user!.fullName
        : "User Name";
    final userEmail = user?.email.isNotEmpty == true ? user!.email : "";
    final userImg = user?.profileImg ?? "";

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
            if (userImg.isNotEmpty)
              ClipOval(
                child: CustomNetworkImage(
                  imageUrl: userImg,
                  height: 80,
                  width: 80,
                  boxShape: BoxShape.circle,
                ),
              )
            else
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
            CustomText(
              userName,
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            if (userEmail.isNotEmpty) ...[
              space4H,
              CustomText(
                userEmail,
                color: AppColors.kBrownTextColor,
                variant: TextVariant.bodyMedium,
              ),
            ],
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
                icon: Icons.storefront_outlined,
                title: "Find Shop",
                onTap: () => context.push(AppRoutes.findShop),
              ),
              // _buildMenuItem(
              //   icon: Icons.notifications_none,
              //   title: "Notifications",
              //   onTap: () => context.push(AppRoutes.notification),
              // ),
            ]),
            // space16H,

            // // MEMBERSHIP Group
            // _buildGroupHeader("MEMBERSHIP"),
            // space8H,
            // _buildProfileCard([

            //   // const Divider(height: 1),
            //   // _buildMenuItem(
            //   //   icon: Icons.card_membership_outlined,
            //   //   title: "Subscription Details",
            //   //   onTap: () {},
            //   // ),
            // ]),
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
                icon: Icons.question_answer_outlined,
                title: "FAQ",
                onTap: () => context.push(AppRoutes.faq),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                onTap: () => context.push(AppRoutes.termsCondition),
              ),
              const Divider(height: 1),
              _buildMenuItem(
                icon: Icons.privacy_tip_outlined,
                title: "Privacy Policy",
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
            ]),
            space24H,

            // Logout Button
            ButtonTapWidget(
              onTap: profileActionState.isLoading
                  ? null
                  : () => _handleLogout(context, ref),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Center(
                  child: profileActionState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red,
                          ),
                        )
                      : const CustomText(
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

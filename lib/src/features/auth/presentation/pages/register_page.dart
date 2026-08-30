import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(onboardingRoleProvider) ?? 'customer';
    final isShop = role == 'shop_owner';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          ButtonTapWidget(
            onTap: () {
              // 1. Update the state to Step 5 (Role Selection)
              ref.read(onboardingStepProvider.notifier).setStep(5);

              // 2. Navigate back to the Splash route where Step 5 is rendered
              context.go(AppRoutes.splash);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const CustomText(
                AppStaticStrings.changeRole,
                color: AppColors.kAccentColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthRoleBadge(role: role),
            space12H,
            const CustomText(
              AppStaticStrings.createAccountTitle,
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
            ),
            space4H,
            CustomText(
              isShop
                  ? AppStaticStrings.shopRegisterSubtitle
                  : AppStaticStrings.customerRegisterSubtitle,
              color: AppColors.kBrownTextColor,
            ),
            space16H,
            if (!isShop) ...[
              const CustomTextField(
                hintText: AppStaticStrings.fullName,
                title: AppStaticStrings.fullName,
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
            ] else ...[
              const CustomTextField(
                hintText: AppStaticStrings.ownerName,
                title: AppStaticStrings.ownerName,
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
              space12H,
              const CustomTextField(
                hintText: AppStaticStrings.shopName,
                title: AppStaticStrings.shopName,
                prefixIcon: Icon(Icons.storefront_outlined, size: 20),
              ),
            ],
            space12H,
            CustomTextField(
              hintText: isShop ? AppStaticStrings.businessEmail : "Email",
              title: isShop ? AppStaticStrings.businessEmail : "Email",
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.phoneNumber,
              title: AppStaticStrings.phoneNumber,
              prefixIcon: Icon(Icons.phone_outlined, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.password,
              title: AppStaticStrings.password,
              isPassword: true,
              prefixIcon: Icon(Icons.lock_outline, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.confirmPassword,
              title: AppStaticStrings.confirmPassword,
              isPassword: true,
              prefixIcon: Icon(Icons.lock_reset, size: 20),
            ),
            space16H,
            CustomButton(
              text: AppStaticStrings.createAccount,
              onPressed: () {},
            ),
            space12H,
            Center(
              child: GestureDetector(
                onTap: () => context.pop(),
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.kBrownTextColor,
                    ),
                    children: const [
                      TextSpan(
                        text: AppStaticStrings.logIn,
                        style: TextStyle(
                          color: AppColors.kAccentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

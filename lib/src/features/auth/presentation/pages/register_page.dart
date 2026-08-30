import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../widgets/auth_role_badge.dart';

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
          TextButton(
            onPressed: () =>
                ref.read(onboardingStepProvider.notifier).setStep(5),
            child: const CustomText(
              AppStaticStrings.changeRole,
              color: AppColors.kYellowColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
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
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
            ] else ...[
              const CustomTextField(
                hintText: AppStaticStrings.ownerName,
                prefixIcon: Icon(Icons.person_outline, size: 20),
              ),
              space12H,
              const CustomTextField(
                hintText: AppStaticStrings.shopName,
                prefixIcon: Icon(Icons.storefront_outlined, size: 20),
              ),
            ],
            space12H,
            CustomTextField(
              hintText: isShop ? AppStaticStrings.businessEmail : "Email",
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.phoneNumber,
              prefixIcon: Icon(Icons.phone_outlined, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.password,
              isPassword: true,
              prefixIcon: Icon(Icons.lock_outline, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: AppStaticStrings.confirmPassword,
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
                          color: AppColors.kYellowColor,
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

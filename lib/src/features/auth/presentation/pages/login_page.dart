import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../widgets/auth_role_badge.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(onboardingRoleProvider) ?? 'customer';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space16H,
              AuthRoleBadge(role: role),
              space16H,
              const CustomText(
                AppStaticStrings.welcomeBack,
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.loginSubtitle,
                variant: TextVariant.bodyMedium,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              const CustomTextField(
                hintText: AppStaticStrings.emailOrPhone,
                prefixIcon: Icon(Icons.mail_outline, size: 20),
              ),
              space12H,
              const CustomTextField(
                hintText: AppStaticStrings.password,
                isPassword: true,
                prefixIcon: Icon(Icons.lock_outline, size: 20),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.forgotPassword),
                  child: const CustomText(
                    AppStaticStrings.forgotPassword,
                    color: AppColors.kYellowColor,
                    variant: TextVariant.labelLarge,
                  ),
                ),
              ),
              space12H,
              CustomButton(text: AppStaticStrings.logIn, onPressed: () {}),
              space16H,
              Center(
                child: GestureDetector(
                  onTap: () => context.push(AppRoutes.register),
                  child: RichText(
                    text: TextSpan(
                      text: AppStaticStrings.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kBrownTextColor,
                      ),
                      children: const [
                        TextSpan(
                          text: AppStaticStrings.signUp,
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
              space16H,
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CustomText("OR", color: AppColors.kBrownTextColor),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              space16H,
              CustomButton(
                text: "Continue with Google",
                isOutlined: true,
                borderColor: AppColors.kBorderColor.withValues(alpha: 0.3),
                textColor: Colors.black,
                onPressed: () {},
              ),
              space8H,
              CustomButton(
                text: "Continue with Apple",
                isOutlined: true,
                borderColor: AppColors.kBorderColor.withValues(alpha: 0.3),
                textColor: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

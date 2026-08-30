import 'package:flutter/material.dart';
import '../../../../src_export.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "Heritage & Hearth",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Center(
          child: Container(
            padding: AppPadding.getPadding16(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade100,
                  radius: 24,
                  child: const Icon(Icons.lock_outlined, color: Colors.black),
                ),
                space12H,
                const CustomText(
                  "Forgot Password?",
                  variant: TextVariant.headlineSmall,
                  fontWeight: FontWeight.bold,
                ),
                space8H,
                const CustomText(
                  "Enter your registered email address and we'll help you reset your password.",
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                ),
                space16H,
                const CustomTextField(
                  hintText: "Email Address",
                  prefixIcon: Icon(Icons.mail_outline),
                ),
                space16H,
                CustomButton(
                  text: AppStaticStrings.continueText,
                  onPressed: () => context.push(AppRoutes.resetPassword),
                ),
                space12H,
                TextButton(
                  onPressed: () => context.pop(),
                  child: const CustomText(
                    "Back to Login",
                    color: AppColors.kYellowColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../src_export.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space16H,
            const CustomText(
              "Set New Password",
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
            ),
            space8H,
            const CustomText(
              "Your new password must be unique and different from previously used passwords. It must contain at least 8 characters, including letters and numbers.",
              variant: TextVariant.bodyMedium,
              color: AppColors.kBrownTextColor,
            ),
            space16H,
            const CustomTextField(
              hintText: "New Password",
              isPassword: true,
              prefixIcon: Icon(Icons.lock_outline, size: 20),
            ),
            space12H,
            const CustomTextField(
              hintText: "Confirm Password",
              isPassword: true,
              prefixIcon: Icon(Icons.lock_reset, size: 20),
            ),
            space16H,
            CustomButton(
              text: "Reset Password",
              onPressed: () {
                // Navigate back to Login route
                context.go(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

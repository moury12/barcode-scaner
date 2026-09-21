
/*
// ─── Change Password Page ───────────────────────────────────────────────────
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.changePassword)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            const CustomTextField(
              title: 'Current Password',
              hintText: "Enter current password",
              isPassword: true,
            ),
            space12H,
            const CustomTextField(
              title: 'New Password',
              hintText: "Enter New Password",
              isPassword: true,
            ),
            space12H,
            const CustomTextField(
              title: 'Confirm New Password',
              hintText: "Enter Confirm New Password",
              isPassword: true,
            ),

            // const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 12),
        child: CustomButton(
          text: AppStaticStrings.updatePassword,
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

// ─── Support Page ───────────────────────────────────────────────────────────
class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.support)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(AppStaticStrings.subject),
            space8H,
            const CustomTextField(
              hintText: AppStaticStrings.writeHere,
              maxLines: 10,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom + 12),
        child: CustomButton(
          text: AppStaticStrings.send,
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

// ─── Terms & Conditions Page ────────────────────────────────────────────────
class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.termsCondition)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: const CustomText(
          'These Terms and Conditions govern your use of PokéLive. By accessing or using our platform, you agree to be bound by these terms. PokéLive provides a marketplace for collectibles, live events, and community interactions.\n\n'
          '1. Eligibility: You must be at least 18 years old to use PokéLive.\n\n'
          '2. Account Responsibility: You are responsible for maintaining the confidentiality of your account credentials.\n\n'
          '3. Prohibited Activities: Users may not engage in fraudulent listings, misrepresentation of items, or any activity that violates applicable laws.\n\n'
          '4. Payments: All transactions are processed securely. PokéLive is not liable for payment failures caused by third-party processors.\n\n'
          '5. Dispute Resolution: Any disputes will be resolved through binding arbitration in accordance with applicable law.\n\n'
          '6. Modifications: PokéLive reserves the right to update these terms at any time with reasonable notice.',
          color: AppColors.kGreyTextColor,
          height: 1.6,
        ),
      ),
    );
  }
}

// ─── Privacy Policy Page ────────────────────────────────────────────────────
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.privacyPolicy)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: const CustomText(
          'Your privacy is important to us. This Privacy Policy explains how PokéLive collects, uses, and protects your personal information.\n\n'
          '1. Information We Collect: We collect personal information such as name, email, shipping address, and payment details when you register or make a purchase.\n\n'
          '2. How We Use Your Information: We use your data to process orders, improve our platform, and communicate important updates.\n\n'
          '3. Data Sharing: We do not sell your personal data. We may share information with trusted partners for payment processing and delivery services.\n\n'
          '4. Cookies: We use cookies to enhance your browsing experience and analyze traffic patterns.\n\n'
          '5. Data Security: We implement industry-standard security measures to protect your data.\n\n'
          '6. Your Rights: You may request access to, correction, or deletion of your personal data at any time by contacting our support team.',
          color: AppColors.kGreyTextColor,
          height: 1.6,
        ),
      ),
    );
  }
}
*/


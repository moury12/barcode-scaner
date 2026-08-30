import '../../../../src_export.dart';

/*
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(
          context,
        ).copyWith(top: MediaQuery.of(context).viewPadding.top),

        child: Column(
          spacing: 12,
          children: [
            // const SizedBox(height: 20),
            SvgPicture.asset(AppAssets.appLogo, height: 80),
            space24H,
            const CustomText(
              AppStaticStrings.createNewPassword,
              variant: TextVariant.headlineLarge,
            ),
            const CustomText(
              AppStaticStrings.resetPassSub,
              textAlign: TextAlign.center,
              color: AppColors.kGreyTextColor,
            ),
            space2H,
            // const SizedBox(height: 40),
            const CustomTextField(
              title: AppStaticStrings.createNewPassword,
              hintText: 'Create Password',
              isPassword: true,
            ),
            space2H,
            // const SizedBox(height: 40),
            CustomButton(
              text: AppStaticStrings.saveChanges,
              onPressed: () => context.go(AppRoutes.login),
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }
}
*/


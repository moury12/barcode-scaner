import '../../../../src_export.dart';

/*
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(
          context,
        ).copyWith(top: MediaQuery.of(context).viewPadding.top + 24),
        child: Column(
          spacing: 12,
          children: [
            // const SizedBox(height: 20),
            SvgPicture.asset(AppAssets.appLogo, height: 80),
            // space24H,
            const CustomText(
              AppStaticStrings.forgotPassTitle,
              variant: TextVariant.headlineLarge,
            ),
            const CustomText(
              AppStaticStrings.forgotPassSub,
              textAlign: TextAlign.center,
              color: AppColors.kGreyTextColor,
            ),
            // const SizedBox(height: 40),
            CustomTextField(
              title: AppStaticStrings.email,
              hintText: 'Email',
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(AppAssets.mailIcon),
              ),
            ),
            // const SizedBox(height: 40),
            CustomButton(
              text: AppStaticStrings.sendOtp,
              onPressed: () => context.push(AppRoutes.otpVerification),
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }
}
*/


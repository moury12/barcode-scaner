import 'package:pinput/pinput.dart';
import '../../../../src_export.dart';

/*
class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

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
            space2H,
            const CustomText(
              AppStaticStrings.verifyOtp,
              variant: TextVariant.headlineLarge,
            ),
            const CustomText(
              AppStaticStrings.verifyOtpSub,
              textAlign: TextAlign.center,
              color: AppColors.kGreyTextColor,
            ),
            space2H,
            // const SizedBox(height: 40),
            Pinput(
              length: 6,
              defaultPinTheme: PinTheme(
                width: 45,
                height: 45,
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.kBorderColor),
                ),
              ),
            ),
            space2H,
            // space24H,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText("Don't get the code ? "),
                GestureDetector(
                  child: const CustomText(
                    AppStaticStrings.resendOtp,
                    color: AppColors.kRedColor,
                  ),
                ),
              ],
            ),
            space2H,
            // const Spacer(),

            // const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPadding.getPadding12(
          context,
        ).copyWith(bottom: MediaQuery.of(context).viewPadding.bottom),
        child: CustomButton(
          text: AppStaticStrings.verifyOtpBtn,
          onPressed: () => context.push(AppRoutes.resetPassword),
          icon: Icons.arrow_forward,
        ),
      ),
    );
  }
}
*/


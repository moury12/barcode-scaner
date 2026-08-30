import '../../../../src_export.dart';

/*
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
            SvgPicture.asset(AppAssets.appLogo, height: 60),
            // space16H,
            const CustomText(
              AppStaticStrings.createAccount,
              variant: TextVariant.headlineLarge,
            ),
            const CustomText(
              AppStaticStrings.signupSub,
              textAlign: TextAlign.center,
              color: AppColors.kGreyTextColor,
            ),
            space2H,
            // const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: 'Name',
                    hintText: AppStaticStrings.firstName,
                  ),
                ),
                space16W,
                Expanded(
                  child: CustomTextField(
                    title: ' ',
                    hintText: AppStaticStrings.lastName,
                  ),
                ),
              ],
            ),
            // space2H,
            const CustomTextField(
              title: AppStaticStrings.email,
              hintText: 'you@gmail.com',
              prefixIcon: Icon(
                Icons.mail_outline,
                color: AppColors.kTextColor,
                size: 20,
              ),
            ),
            // space16H,
            const CustomTextField(
              title: AppStaticStrings.contactNumber,
              hintText: 'eg, 012546566',
              prefixIcon: Icon(
                Icons.phone_outlined,
                color: AppColors.kTextColor,
                size: 20,
              ),
            ),
            // space16H,
            const CustomTextField(
              title: AppStaticStrings.password,
              hintText: 'Password',
              isPassword: true,
            ),
            space2H,
            // space24H,
            CustomButton(
              text: AppStaticStrings.createAccount,
              onPressed: () {},
              icon: Icons.arrow_forward,
            ),
            // space2H,
            // space24H,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText("Don't have an account ? "),
                ButtonTapWidget(
                  onTap: () => context.pop(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CustomText(
                      'Sign Up',
                      color: AppColors.kRedColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
*/


import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

/*
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(
          context,
        ).copyWith(top: MediaQuery.of(context).viewPadding.top + 24),
        child: Column(
          spacing: 8,
          children: [
            // const SizedBox(height: 80),
            SvgPicture.asset(AppAssets.appLogo, height: 80),
            // space24H,
            const CustomText(
              AppStaticStrings.logIn,
              variant: TextVariant.headlineLarge,
            ),
            const CustomText(
              AppStaticStrings.connectShopShare,
              color: AppColors.kGreyTextColor,
              textAlign: TextAlign.center,
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
            // space16H,
            const CustomTextField(
              title: AppStaticStrings.password,
              hintText: 'Password',
              isPassword: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ButtonTapWidget(
                onTap: () => context.push(AppRoutes.emailConfirmation),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const CustomText(
                    AppStaticStrings.forgotPassword,
                    color: AppColors.kRedColor,
                    variant: TextVariant.labelMedium,
                  ),
                ),
              ),
            ),
            // space24H,
            CustomButton(
              text: AppStaticStrings.logIn,
              onPressed: () {
                context.go(AppRoutes.home);
              }, // Logic not needed
              icon: Icons.arrow_forward,
            ),
            // space24H,
            Row(
              spacing: 12,
              children: [
                Expanded(child: Divider(thickness: .5)),
                const CustomText(
                  AppStaticStrings.or,
                  color: AppColors.kGreyTextColor,
                ),
                Expanded(child: Divider(thickness: .5)),
              ],
            ),
            // space24H,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(AppStaticStrings.dontHaveAccount),
                ButtonTapWidget(
                  onTap: () => context.push(AppRoutes.register),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CustomText(
                      AppStaticStrings.signUp,
                      color: AppColors.kRedColor,
                      variant: TextVariant.labelMedium,
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


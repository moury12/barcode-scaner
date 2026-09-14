import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(loginControllerProvider.notifier).loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    final loginState = ref.read(loginControllerProvider);
    if (success) {
      CustomSnackbar.show(
        context,
        loginState.successMessage ?? 'Login successful',
        isError: false,
      );
      context.go(AppRoutes.mainLayout);
    } else {
      CustomSnackbar.show(
        context,
        loginState.errorMessage ?? 'Login failed',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space12H,
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
                CustomTextField(
                  textEditingController: _emailController,
                  hintText: "Email",
                  title: "Email",
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.mail_outline, size: 20),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!val.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                space12H,
                CustomTextField(
                  textEditingController: _passwordController,
                  hintText: AppStaticStrings.password,
                  title: AppStaticStrings.password,
                  isPassword: true,
                  isRequired: true,
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                space8H,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTapWidget(
                      onTap: () {
                        context.push(
                          AppRoutes.otpVerification,
                          extra: {
                            'email': _emailController.text.trim(),
                            'isForgotPassword': false,
                          },
                        );
                      },
                      child: const CustomText(
                        "Verify Account?",
                        color: AppColors.kPrimaryColor,
                        variant: TextVariant.labelLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ButtonTapWidget(
                      onTap: () => context.push(AppRoutes.forgotPassword),
                      child: const CustomText(
                        AppStaticStrings.forgotPassword,
                        color: AppColors.kAccentColor,
                        variant: TextVariant.labelLarge,
                      ),
                    ),
                  ],
                ),
                space16H,
                CustomButton(
                  text: AppStaticStrings.logIn,
                  isLoading: loginState.isLoading,
                  onPressed: () => _handleLogin(),
                ),
                space12H,
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
                              color: AppColors.kAccentColor,
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
                space12H,
                CustomButton(
                  text: "Continue with Google",
                  isOutlined: true,
                  img: AppStaticStrings.googleIcon,
                  borderColor: AppColors.kBorderColor.withValues(alpha: 0.3),
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                space8H,
                CustomButton(
                  text: "Continue with Apple",
                  isOutlined: true,
                  img: AppStaticStrings.appleIcon,
                  borderColor: AppColors.kBorderColor.withValues(alpha: 0.3),
                  textColor: Colors.black,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

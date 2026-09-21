import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController(text: kDebugMode ? "TestUser" : "");
  final _emailController = TextEditingController(text: kDebugMode ? "bifigow685@hideam.com" : "");
  final _phoneController = TextEditingController(text: kDebugMode ? "0123456789" : "");
  final _passwordController = TextEditingController(text: kDebugMode ? "123456A" : "");
  final _confirmPasswordController = TextEditingController(text: kDebugMode ? "123456A" : "");

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      CustomSnackbar.show(
        context,
        'Passwords do not match',
        isError: true,
      );
      return;
    }

    final success = await ref
        .read(registerControllerProvider.notifier)
        .registerCustomer(
          fullName: _fullNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text.trim(),
        );

    if (!mounted) return;

    final state = ref.read(registerControllerProvider);
    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'Please check your email to verify',
        isError: false,
      );
      context.push(
        AppRoutes.otpVerification,
        extra: {
          'email': _emailController.text.trim(),
          'isForgotPassword': false,
        },
      );
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Registration failed',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space12H,
              const CustomText(
                AppStaticStrings.createAccountTitle,
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
              ),
              space4H,
              const CustomText(
                AppStaticStrings.customerRegisterSubtitle,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              CustomTextField(
                textEditingController: _fullNameController,
                hintText: AppStaticStrings.fullName,
                title: AppStaticStrings.fullName,
                isRequired: true,
                prefixIcon: const Icon(Icons.person_outline, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
              ),
              space12H,
              CustomTextField(
                textEditingController: _emailController,
                hintText: "Email",
                title: "Email",
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
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
                textEditingController: _phoneController,
                hintText: AppStaticStrings.phoneNumber,
                title: AppStaticStrings.phoneNumber,
                isRequired: true,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Phone number is required';
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
                  if (val.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              space12H,
              CustomTextField(
                textEditingController: _confirmPasswordController,
                hintText: AppStaticStrings.confirmPassword,
                title: AppStaticStrings.confirmPassword,
                isPassword: true,
                isRequired: true,
                prefixIcon: const Icon(Icons.lock_reset, size: 20),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please confirm password';
                  }
                  return null;
                },
              ),
              space16H,
              CustomButton(
                text: AppStaticStrings.createAccount,
                isLoading: registerState.isLoading,
                onPressed: () => _handleRegister(),
              ),
              space12H,
              Center(
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.kBrownTextColor,
                      ),
                      children: const [
                        TextSpan(
                          text: AppStaticStrings.logIn,
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
              space12H,
              Center(
                child: GestureDetector(
                  onTap: () => context.push(
                    AppRoutes.otpVerification,
                    extra: {
                      'email': _emailController.text.trim(),
                      'isForgotPassword': false,
                    },
                  ),
                  child: const CustomText(
                    "Need to verify your account? Verify Here",
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              space24H,
            ],
          ),
        ),
      ),
    );
  }
}

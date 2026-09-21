import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final success = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .sendOtp(email: email);

    if (!mounted) return;

    final state = ref.read(forgotPasswordControllerProvider);
    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'OTP has been sent to your email address.',
        isError: false,
      );
      context.push(
        AppRoutes.otpVerification,
        extra: {
          'email': email,
          'isForgotPassword': true,
        },
      );
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Failed to send OTP',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(forgotPasswordControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Center(
          child: Container(
            padding: AppPadding.getPadding16(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Form(
              key: _formKey,
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
                    "Enter your registered email address and we'll send an OTP to reset your password.",
                    textAlign: TextAlign.center,
                    color: AppColors.kBrownTextColor,
                  ),
                  space16H,
                  CustomTextField(
                    textEditingController: _emailController,
                    hintText: "Email Address",
                    title: "Email Address",
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline),
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
                  space16H,
                  CustomButton(
                    text: AppStaticStrings.continueText,
                    isLoading: state.isLoading,
                    onPressed: () => _handleSendOtp(),
                  ),
                  space12H,
                  ButtonTapWidget(
                    onTap: () => context.pop(),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomText(
                        "Back to Login",
                        color: AppColors.kAccentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

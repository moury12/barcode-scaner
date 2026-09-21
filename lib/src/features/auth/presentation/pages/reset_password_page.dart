import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String? email;
  final String? token;

  const ResetPasswordPage({
    super.key,
    this.email,
    this.token,
  });

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    if (_newPasswordController.text != _confirmPasswordController.text) {
      CustomSnackbar.show(
        context,
        'Passwords do not match',
        isError: true,
      );
      return;
    }

    final email = widget.email ?? '';
    final token = widget.token ?? '';

    final success = await ref
        .read(forgotPasswordControllerProvider.notifier)
        .resetPassword(
          email: email,
          token: token,
          newPassword: _newPasswordController.text,
        );

    if (!mounted) return;

    final state = ref.read(forgotPasswordControllerProvider);
    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'Password reset successfully!',
        isError: false,
      );
      context.go(AppRoutes.login);
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Password reset failed',
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
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Form(
          key: _formKey,
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
                "Your new password must be unique and different from previously used passwords. It must contain at least 6 characters.",
                variant: TextVariant.bodyMedium,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              CustomTextField(
                textEditingController: _newPasswordController,
                hintText: "New Password",
                title: "New Password",
                isPassword: true,
                isRequired: true,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter new password';
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
                hintText: "Confirm Password",
                title: "Confirm Password",
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
                text: "Reset Password",
                isLoading: state.isLoading,
                onPressed: () => _handleResetPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

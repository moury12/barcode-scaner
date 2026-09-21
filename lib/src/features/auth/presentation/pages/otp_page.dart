import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../../../src_export.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String? email;
  final bool isForgotPassword;

  const OtpPage({
    super.key,
    this.email,
    this.isForgotPassword = false,
  });

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  late final TextEditingController _emailController;
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int _resendTimerSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.email ?? '');
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _resendTimerSeconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimerSeconds > 0) {
        if (mounted) setState(() => _resendTimerSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final otp = _otpController.text.trim();

    if (otp.length < 6) {
      CustomSnackbar.show(
        context,
        'Please enter the full 6-digit OTP code',
        isError: true,
      );
      return;
    }

    if (widget.isForgotPassword) {
      final success = await ref
          .read(otpControllerProvider.notifier)
          .verifyForgotPasswordOtp(email: email, otp: otp);

      if (!mounted) return;
      final state = ref.read(otpControllerProvider);

      if (success) {
        CustomSnackbar.show(
          context,
          state.successMessage ?? 'OTP is verified successfully.',
          isError: false,
        );
        context.push(
          AppRoutes.resetPassword,
          extra: {
            'email': email,
            'token': state.resetToken,
          },
        );
      } else {
        CustomSnackbar.show(
          context,
          state.errorMessage ?? 'OTP verification failed',
          isError: true,
        );
      }
    } else {
      final success = await ref
          .read(otpControllerProvider.notifier)
          .verifyAccount(email: email, otp: otp);

      if (!mounted) return;
      final state = ref.read(otpControllerProvider);

      if (success) {
        CustomSnackbar.show(
          context,
          state.successMessage ?? 'Your account is verified successfully',
          isError: false,
        );
        context.go(AppRoutes.login);
      } else {
        CustomSnackbar.show(
          context,
          state.errorMessage ?? 'Verification failed',
          isError: true,
        );
      }
    }
  }

  Future<void> _handleResend() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      CustomSnackbar.show(context, 'Please enter a valid email', isError: true);
      return;
    }

    bool success;
    if (widget.isForgotPassword) {
      success = await ref
          .read(otpControllerProvider.notifier)
          .sendForgotPasswordOtp(email: email);
    } else {
      success = await ref
          .read(otpControllerProvider.notifier)
          .resendVerificationEmail(email: email);
    }

    if (!mounted) return;
    final state = ref.read(otpControllerProvider);

    if (success) {
      CustomSnackbar.show(
        context,
        state.successMessage ?? 'Verification code sent!',
        isError: false,
      );
      _startTimer();
    } else {
      CustomSnackbar.show(
        context,
        state.errorMessage ?? 'Failed to resend code',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpControllerProvider);

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 52,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.kTextColor,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.kBorderColor),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.kPrimaryColor, width: 2),
      ),
    );

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space12H,
              CircleAvatar(
                backgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                radius: 32,
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 32,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              space16H,
              CustomText(
                widget.isForgotPassword
                    ? "Verify Forgot Password OTP"
                    : "Verify Your Account",
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              space8H,
              const CustomText(
                "Enter the 6-digit verification code sent to your email.",
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
              space16H,
              Pinput(
                length: 6,
                controller: _otpController,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (pin) => _handleVerify(),
              ),
              space24H,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    "Didn't receive the code? ",
                    color: AppColors.kBrownTextColor,
                  ),
                  _resendTimerSeconds > 0
                      ? CustomText(
                          "Resend in ${_resendTimerSeconds}s",
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        )
                      : GestureDetector(
                          onTap: otpState.isResending ? null : _handleResend,
                          child: const CustomText(
                            "Resend OTP",
                            color: AppColors.kAccentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
              space24H,
              CustomButton(
                text: "Verify OTP",
                isLoading: otpState.isLoading,
                onPressed: () => _handleVerify(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

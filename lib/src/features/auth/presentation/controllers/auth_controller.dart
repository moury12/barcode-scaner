import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../../data/datasources/auth_remote_datasource.dart';

// ─── LOGIN STATE & CONTROLLER ───
class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });
}

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  Future<bool> loginUser({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    state = const LoginState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.loginUser(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );

      final data = res['data'] as Map<String, dynamic>?;
      if (data != null) {
        final accessToken = data['accessToken'] as String?;
        final refreshToken = data['refreshToken'] as String?;
        if (accessToken != null && refreshToken != null) {
          final storage = ref.read(localStorageServiceProvider);
          await storage.saveTokens(accessToken, refreshToken);
        }
      }

      final message = res['message'] as String? ?? 'Login successful';
      state = LoginState(isLoading: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = LoginState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }
}

final loginControllerProvider =
    NotifierProvider<LoginController, LoginState>(LoginController.new);

// ─── REGISTER CONTROLLER ───
class RegisterState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const RegisterState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  RegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class RegisterController extends Notifier<RegisterState> {
  @override
  RegisterState build() => const RegisterState();

  Future<bool> registerCustomer({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.registerCustomer(
        fullName: fullName,
        email: email,
        password: password,
        phone: phone,
      );

      final message = res['message'] as String? ?? 'Please check your email to verify';
      state = RegisterState(isLoading: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = RegisterState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }
}

final registerControllerProvider =
    NotifierProvider<RegisterController, RegisterState>(RegisterController.new);

// ─── OTP CONTROLLER ───
class OtpState {
  final bool isLoading;
  final bool isResending;
  final String? errorMessage;
  final String? successMessage;
  final String? resetToken;

  const OtpState({
    this.isLoading = false,
    this.isResending = false,
    this.errorMessage,
    this.successMessage,
    this.resetToken,
  });
}

class OtpController extends Notifier<OtpState> {
  @override
  OtpState build() => const OtpState();

  Future<bool> verifyAccount({
    required String email,
    required String otp,
  }) async {
    state = const OtpState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.verifyAccount(email: email, otp: otp);
      final message = res['message'] as String? ?? 'Your account is verified successfully';
      state = OtpState(isLoading: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = OtpState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }

  Future<bool> resendVerificationEmail({required String email}) async {
    state = const OtpState(isResending: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.resendVerificationEmail(email: email);
      final message = res['message'] as String? ?? 'Verification email resent. Please check your inbox.';
      state = OtpState(isResending: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = OtpState(isResending: false, errorMessage: cleanMsg);
      return false;
    }
  }

  Future<bool> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    state = const OtpState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.verifyForgotPasswordOtp(email: email, otp: otp);
      final data = res['data'] as Map<String, dynamic>?;
      final token = data?['token'] as String?;
      final message = res['message'] as String? ?? 'OTP is verified successfully.';
      state = OtpState(isLoading: false, successMessage: message, resetToken: token);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = OtpState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }

  Future<bool> sendForgotPasswordOtp({required String email}) async {
    state = const OtpState(isResending: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.sendForgotPasswordOtp(email: email);
      final message = res['message'] as String? ?? 'OTP has been sent to your email address.';
      state = OtpState(isResending: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = OtpState(isResending: false, errorMessage: cleanMsg);
      return false;
    }
  }
}

final otpControllerProvider =
    NotifierProvider<OtpController, OtpState>(OtpController.new);

// ─── FORGOT & RESET PASSWORD CONTROLLER ───
class ForgotPasswordState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });
}

class ForgotPasswordController extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  Future<bool> sendOtp({required String email}) async {
    state = const ForgotPasswordState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.sendForgotPasswordOtp(email: email);
      final message = res['message'] as String? ?? 'OTP has been sent to your email address.';
      state = ForgotPasswordState(isLoading: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = ForgotPasswordState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    state = const ForgotPasswordState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.resetPassword(
        email: email,
        token: token,
        newPassword: newPassword,
      );
      final message = res['message'] as String? ?? 'Password reset successfully';
      state = ForgotPasswordState(isLoading: false, successMessage: message);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = ForgotPasswordState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }
}

final forgotPasswordControllerProvider =
    NotifierProvider<ForgotPasswordController, ForgotPasswordState>(
        ForgotPasswordController.new);

// ─── PROFILE / ACCOUNT ACTION CONTROLLER ───
class ProfileActionState {
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const ProfileActionState({
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });
}

class ProfileActionController extends Notifier<ProfileActionState> {
  @override
  ProfileActionState build() => const ProfileActionState();

  Future<bool> logout() async {
    state = const ProfileActionState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      await dataSource.logout();
      state = const ProfileActionState(isLoading: false, successMessage: 'User logged out successfully');
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = ProfileActionState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }

  Future<bool> deleteAccount({required String password}) async {
    state = const ProfileActionState(isLoading: true);
    try {
      final dataSource = ref.read(authRemoteDataSourceProvider);
      final res = await dataSource.deleteAccount(password: password);
      final msg = res['message'] as String? ?? 'Account deleted successfully';
      state = ProfileActionState(isLoading: false, successMessage: msg);
      return true;
    } catch (e) {
      final cleanMsg = e.toString().replaceAll('Exception: ', '');
      state = ProfileActionState(isLoading: false, errorMessage: cleanMsg);
      return false;
    }
  }
}

final profileActionControllerProvider =
    NotifierProvider<ProfileActionController, ProfileActionState>(
        ProfileActionController.new);

// Legacy compat provider
final authProvider = NotifierProvider<AuthController, bool>(AuthController.new);

class AuthController extends Notifier<bool> {
  @override
  bool build() => false;

  void login(BuildContext context) {
    state = true;
    Future.delayed(const Duration(seconds: 2), () {
      state = false;
      if (context.mounted) {
        context.go(AppRoutes.mainLayout);
      }
    });
  }
}

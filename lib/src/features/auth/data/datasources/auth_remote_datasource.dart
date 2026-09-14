import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    bool rememberMe = false,
  });

  Future<Map<String, dynamic>> registerCustomer({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  });

  Future<Map<String, dynamic>> verifyAccount({
    required String email,
    required String otp,
  });

  Future<Map<String, dynamic>> resendVerificationEmail({
    required String email,
  });

  Future<Map<String, dynamic>> sendForgotPasswordOtp({
    required String email,
  });

  Future<Map<String, dynamic>> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  });

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  });

  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _api;
  AuthRemoteDataSourceImpl(this._api);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final res = await loginUser(email: email, password: password);
    final data = res['data'] as Map<String, dynamic>? ?? {};
    return UserModel.fromJson(data);
  }

  @override
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final response = await _api.post(
      '/auth/login-user',
      data: {
        'email': email,
        'password': password,
        'rememberMe': rememberMe,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Login failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> registerCustomer({
    required String fullName,
    required String email,
    required String password,
    required String phone,
  }) async {
    final response = await _api.post(
      '/auth/register-customer',
      data: {
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {'success': true, 'message': 'Please check your email to verify'};
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Registration failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyAccount({
    required String email,
    required String otp,
  }) async {
    final response = await _api.post(
      '/auth/verify-account',
      data: {
        'email': email,
        'otp': otp,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Account verification failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> resendVerificationEmail({
    required String email,
  }) async {
    final response = await _api.post(
      '/auth/resend-verification-email',
      data: {
        'email': email,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Resend verification failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> sendForgotPasswordOtp({
    required String email,
  }) async {
    final response = await _api.post(
      '/auth/forgot-password/send-otp',
      data: {
        'email': email,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Send OTP failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _api.post(
      '/auth/forgot-password/verify-otp',
      data: {
        'email': email,
        'otp': otp,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'OTP verification failed';
      throw Exception(msg);
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    final response = await _api.post(
      '/auth/forgot-password/reset-password',
      data: {
        'email': email,
        'token': token,
        'newPassword': newPassword,
      },
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    } else {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message']
          : 'Reset password failed';
      throw Exception(msg);
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }
}

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
});

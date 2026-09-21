import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../models/user_profile_model.dart';

abstract class UserRemoteDataSource {
  Future<UserProfileModel> getMyProfile();
  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String phone,
    String? imagePath,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService _api;

  UserRemoteDataSourceImpl(this._api);

  @override
  Future<UserProfileModel> getMyProfile() async {
    final response = await _api.get('/user/my-profile');
    if (response.data != null && response.data['success'] == true) {
      final data = response.data['data'] as Map<String, dynamic>?;
      if (data != null) return UserProfileModel.fromJson(data);
    }
    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to fetch user profile';
    throw Exception(msg);
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String fullName,
    required String phone,
    String? imagePath,
  }) async {
    final formDataMap = <String, dynamic>{
      'fullName': fullName,
      'phone': phone,
    };

    if (imagePath != null && imagePath.isNotEmpty) {
      final filename = imagePath.split('/').last;
      formDataMap['image'] = await MultipartFile.fromFile(
        imagePath,
        filename: filename,
      );
    }

    final formData = FormData.fromMap(formDataMap);

    final response = await _api.patch(
      '/user/update-profile',
      data: formData,
    );

    if (response.data != null && response.data['success'] == true) {
      return response.data as Map<String, dynamic>;
    }

    final msg = (response.data is Map && response.data['message'] != null)
        ? response.data['message']
        : 'Failed to update profile';
    throw Exception(msg);
  }
}

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  final api = ref.watch(apiServiceProvider);
  return UserRemoteDataSourceImpl(api);
});

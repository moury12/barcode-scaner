import 'package:flutter_riverpod/legacy.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/models/user_profile_model.dart';

class UserProfileState {
  final bool isLoading;
  final UserProfileModel? profile;
  final String? errorMessage;
  final String? successMessage;

  const UserProfileState({
    this.isLoading = false,
    this.profile,
    this.errorMessage,
    this.successMessage,
  });

  UserProfileState copyWith({
    bool? isLoading,
    UserProfileModel? profile,
    String? errorMessage,
    String? successMessage,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  final UserRemoteDataSource _dataSource;

  UserProfileNotifier(this._dataSource) : super(const UserProfileState()) {
    fetchProfile();
  }

  Future<void> fetchProfile({bool force = false}) async {
    if (state.profile != null && !force && !state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final profile = await _dataSource.getMyProfile();
      state = state.copyWith(
        isLoading: false,
        profile: profile,
      );
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(
        isLoading: false,
        errorMessage: msg,
      );
    }
  }

  Future<bool> updateProfile({
    required String fullName,
    required String phone,
    String? imagePath,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    try {
      final res = await _dataSource.updateProfile(
        fullName: fullName,
        phone: phone,
        imagePath: imagePath,
      );

      final msg = res['message'] as String? ?? 'Profile updated successfully';

      // Refetch profile after update
      final updatedProfile = await _dataSource.getMyProfile();

      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
        successMessage: msg,
      );
      return true;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(
        isLoading: false,
        errorMessage: msg,
      );
      return false;
    }
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
  final ds = ref.watch(userRemoteDataSourceProvider);
  return UserProfileNotifier(ds);
});

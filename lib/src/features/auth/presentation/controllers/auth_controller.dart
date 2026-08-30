import 'package:flutter_riverpod/legacy.dart';
import '../../../../src_export.dart';

final authProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<bool> {
  AuthController() : super(false);

  void login(BuildContext context) {
    state = true; // Loading
    Future.delayed(const Duration(seconds: 2), () {
      state = false;
      context.go(AppRoutes.home);
    });
  }
}

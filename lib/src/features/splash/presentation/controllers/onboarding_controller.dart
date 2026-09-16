import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/local_storage_service.dart';

class OnboardingStepNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setStep(int step) => state = step;

  void nextStep() {
    if (state < 4) state++;
  }

  void previousStep() {
    if (state > 0) state--;
  }

  Future<void> markCompleted() async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.setOnboardingCompleted(true);
  }
}

final onboardingStepProvider =
    NotifierProvider<OnboardingStepNotifier, int>(OnboardingStepNotifier.new);

class OnboardingRoleNotifier extends Notifier<String?> {
  @override
  String? build() {
    final storage = ref.read(localStorageServiceProvider);
    final storedRole = storage.userRole;
    if (storedRole != null) {
      return storedRole == 'owner' ? 'shop_owner' : storedRole;
    }
    return 'customer';
  }

  void selectRole(String role) => state = role;
}

final onboardingRoleProvider =
    NotifierProvider<OnboardingRoleNotifier, String?>(OnboardingRoleNotifier.new);

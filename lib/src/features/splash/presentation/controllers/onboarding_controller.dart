import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingStepNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setStep(int step) => state = step;
  
  void nextStep() {
    if (state < 5) state++;
  }

  void previousStep() {
    if (state > 0) state--;
  }
}

final onboardingStepProvider = NotifierProvider<OnboardingStepNotifier, int>(OnboardingStepNotifier.new);

class OnboardingRoleNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void selectRole(String role) => state = role;
}

final onboardingRoleProvider = NotifierProvider<OnboardingRoleNotifier, String?>(OnboardingRoleNotifier.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to manage current step of onboarding
// 0: Splash, 1: Slide 1, 2: Slide 2, 3: Slide 3, 4: Welcome, 5: Role Selection
class OnboardingStepNotifier extends Notifier<int> {
  @override
  int build() => 0;

  @override
  set state(int step) => super.state = step;
}

final onboardingStepProvider = NotifierProvider<OnboardingStepNotifier, int>(OnboardingStepNotifier.new);

// Provider to manage selected role: 'customer' or 'shop_owner'
class OnboardingRoleNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  @override
  set state(String? role) => super.state = role;
}


final onboardingRoleProvider = NotifierProvider<OnboardingRoleNotifier, String?>(OnboardingRoleNotifier.new);

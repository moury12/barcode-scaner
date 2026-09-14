import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _initAppFlow();
  }

  Future<void> _initAppFlow() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final storage = ref.read(localStorageServiceProvider);
    final isCompleted = storage.isOnboardingCompleted;

    if (isCompleted) {
      if (storage.accessToken != null && storage.accessToken!.isNotEmpty) {
        context.go(AppRoutes.mainLayout);
      } else {
        context.go(AppRoutes.login);
      }
    } else {
      if (ref.read(onboardingStepProvider) == 0) {
        ref.read(onboardingStepProvider.notifier).setStep(1);
      }
    }
  }

  Future<void> _completeAndNavigate(String route) async {
    await ref.read(onboardingStepProvider.notifier).markCompleted();
    if (!mounted) return;
    context.go(route);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(onboardingStepProvider);

    // 1. SPLASH SCREEN (Step 0)
    if (step == 0) {
      return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppStaticStrings.appLogo, height: 150),
              space12H,
              const CustomText(
                AppStaticStrings.appName,
                variant: TextVariant.displaySmall,
                color: Colors.white,
              ),
              space8H,
              const CustomText(
                AppStaticStrings.appSubtitle,
                variant: TextVariant.bodyMedium,
                color: Colors.white70,
              ),
            ],
          ),
        ),
      );
    }

    // 2. WELCOME SCREEN (Step 4)
    if (step == 4) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () =>
                ref.read(onboardingStepProvider.notifier).setStep(3),
          ),
        ),
        body: Column(
          children: [
            SvgPicture.asset(
              AppStaticStrings.cupIcon,
              height: 32,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            space12H,
            const CustomText(
              AppStaticStrings.appName,
              variant: TextVariant.titleLarge,
              color: AppColors.kPrimaryColor,
            ),
            space12H,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    AppStaticStrings.onboardingImg4,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  const CustomText(
                    AppStaticStrings.onboardingTitle4,
                    variant: TextVariant.headlineLarge,
                    color: AppColors.kPrimaryColor,
                  ),
                  space12H,
                  const CustomText(
                    AppStaticStrings.onboardingDesc4,
                    variant: TextVariant.bodyMedium,
                    color: AppColors.kBrownTextColor,
                    textAlign: TextAlign.center,
                  ),
                  space12H,
                  CustomButton(
                    text: AppStaticStrings.getStarted,
                    onPressed: () => _completeAndNavigate(AppRoutes.register),
                  ),
                  space12H,
                  CustomButton(
                    text: AppStaticStrings.alreadyHaveAccount,
                    onPressed: () => _completeAndNavigate(AppRoutes.login),
                    isOutlined: true,
                    textColor: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 3. ONBOARDING SLIDES (Steps 1, 2, 3)
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (i) =>
                ref.read(onboardingStepProvider.notifier).setStep(i + 1),
            children: const [
              OnboardingSlide(
                imagePath: AppStaticStrings.onboardingImg1,
                title: AppStaticStrings.onboardingTitle1,
                description: AppStaticStrings.onboardingDesc1,
              ),
              OnboardingSlide(
                imagePath: AppStaticStrings.onboardingImg2,
                title: AppStaticStrings.onboardingTitle2,
                description: AppStaticStrings.onboardingDesc2,
              ),
              OnboardingSlide(
                imagePath: AppStaticStrings.onboardingImg3,
                title: AppStaticStrings.onboardingTitle3,
                description: AppStaticStrings.onboardingDesc3,
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: (step - 1) == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: (step - 1) == index
                            ? AppColors.kPrimaryColor
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                space12H,
                CustomButton(
                  text: AppStaticStrings.next,
                  onPressed: () {
                    if (step < 3) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      ref.read(onboardingStepProvider.notifier).setStep(4);
                    }
                  },
                ),
                space12H,
                CustomButton(
                  text: AppStaticStrings.skip,
                  onPressed: () => _completeAndNavigate(AppRoutes.login),
                  isOutlined: true,
                  textColor: AppColors.kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

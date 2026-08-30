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
    
    // Auto-advance from Splash (step 0) to Onboarding Slide 1 (step 1) after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && ref.read(onboardingStepProvider) == 0) {
        ref.read(onboardingStepProvider.notifier).state = 1;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = ref.watch(onboardingStepProvider);
    final selectedRole = ref.watch(onboardingRoleProvider);

    // Sync PageController when step changes externally
    if (_pageController.hasClients && step >= 1 && step <= 3) {
      final currentPage = _pageController.page?.round() ?? 1;
      if (currentPage != (step - 1)) {
        _pageController.animateToPage(
          step - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    // ─── STEP 0: Splash Screen ──────────────────────────────────────────────
    if (step == 0) {
      return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // White Card Logo Container
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  AppStaticStrings.cupIcon,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomText(
                AppStaticStrings.appName,
                variant: TextVariant.headlineLarge,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              CustomText(
                AppStaticStrings.appSubtitle,
                variant: TextVariant.bodyMedium,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      );
    }

    // ─── STEP 5: Role Selection Screen ──────────────────────────────────────
    if (step == 5) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.kPrimaryColor),
            onPressed: () {
              ref.read(onboardingStepProvider.notifier).state = 4;
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomText(
                AppStaticStrings.roleSelectionTitle,
                variant: TextVariant.headlineLarge,
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              CustomText(
                AppStaticStrings.roleSelectionDesc,
                variant: TextVariant.bodyMedium,
                color: AppColors.kGreyTextColor,
              ),
              const SizedBox(height: 40),
              
              // Role: Customer Card
              GestureDetector(
                onTap: () {
                  ref.read(onboardingRoleProvider.notifier).state = 'customer';
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedRole == 'customer'
                        ? AppColors.kPrimaryColor.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selectedRole == 'customer'
                          ? AppColors.kPrimaryColor
                          : AppColors.kBorderColor.withValues(alpha: 0.3),
                      width: selectedRole == 'customer' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_outline,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStaticStrings.roleCustomerTitle,
                              variant: TextVariant.titleMedium,
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              AppStaticStrings.roleCustomerDesc,
                              variant: TextVariant.bodySmall,
                              color: AppColors.kGreyTextColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Role: Shop Owner Card
              GestureDetector(
                onTap: () {
                  ref.read(onboardingRoleProvider.notifier).state = 'shop_owner';
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: selectedRole == 'shop_owner'
                        ? AppColors.kPrimaryColor.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: selectedRole == 'shop_owner'
                          ? AppColors.kPrimaryColor
                          : AppColors.kBorderColor.withValues(alpha: 0.3),
                      width: selectedRole == 'shop_owner' ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront_outlined,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              AppStaticStrings.roleShopOwnerTitle,
                              variant: TextVariant.titleMedium,
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              AppStaticStrings.roleShopOwnerDesc,
                              variant: TextVariant.bodySmall,
                              color: AppColors.kGreyTextColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),
              CustomButton(
                text: AppStaticStrings.continueText,
                onPressed: selectedRole != null ? () {
                  // Navigate to corresponding screen based on role
                  // (For mock validation, we go to Login)
                  context.push(AppRoutes.login);
                } : () {},
                backgroundColor: selectedRole != null ? AppColors.kPrimaryColor : Colors.grey[400],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }

    // ─── STEP 4: Welcome Slide ──────────────────────────────────────────────
    if (step == 4) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppStaticStrings.onboardingImg4),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppStaticStrings.cupIcon,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                          AppColors.kPrimaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        AppStaticStrings.appName,
                        variant: TextVariant.titleLarge,
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    AppStaticStrings.onboardingTitle4,
                    variant: TextVariant.headlineLarge,
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    AppStaticStrings.onboardingDesc4,
                    variant: TextVariant.bodyMedium,
                    color: AppColors.kGreyTextColor,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: AppStaticStrings.getStarted,
                    onPressed: () {
                      ref.read(onboardingStepProvider.notifier).state = 5;
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: AppStaticStrings.alreadyHaveAccount,
                    onPressed: () {
                      // Navigate to Login directly
                      context.push(AppRoutes.login);
                    },
                    isOutlined: true,
                    borderColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // ─── STEP 1-3: Onboarding Slides ────────────────────────────────────────
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (pageIndex) {
              ref.read(onboardingStepProvider.notifier).state = pageIndex + 1;
            },
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
          
          // Floating Dot Indicators and Buttons overlaying bottom of Slide
          Positioned(
            left: 24,
            right: 24,
            bottom: 32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Dot Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final isSelected = (step - 1) == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: isSelected ? 24 : 8,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : AppColors.kBorderColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 32),
                
                // Next Button
                CustomButton(
                  text: AppStaticStrings.next,
                  onPressed: () {
                    if (step < 3) {
                      ref.read(onboardingStepProvider.notifier).state = step + 1;
                    } else {
                      ref.read(onboardingStepProvider.notifier).state = 4;
                    }
                  },
                ),
                const SizedBox(height: 12),
                
                // Skip Button
                CustomButton(
                  text: AppStaticStrings.skip,
                  onPressed: () {
                    ref.read(onboardingStepProvider.notifier).state = 4;
                  },
                  isOutlined: true,
                  borderColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
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

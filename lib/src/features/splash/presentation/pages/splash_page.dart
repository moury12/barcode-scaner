import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../widgets/role_selection_card.dart';

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
    
    // Step 0 -> Step 1 after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && ref.read(onboardingStepProvider) == 0) {
        ref.read(onboardingStepProvider.notifier).setStep(1);
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

    // 1. SPLASH SCREEN (Step 0)
    if (step == 0) {
      return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(AppStaticStrings.cupIcon,
                    colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn)),
              ),
              const SizedBox(height: 24),
              CustomText(AppStaticStrings.appName, variant: TextVariant.displaySmall, color: Colors.white),
              const SizedBox(height: 8),
              CustomText(AppStaticStrings.appSubtitle, variant: TextVariant.bodyMedium, color: Colors.white70),
            ],
          ),
        ),
      );
    }

    // 2. ROLE SELECTION (Step 5)
    if (step == 5) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => ref.read(onboardingStepProvider.notifier).setStep(4),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(AppStaticStrings.roleSelectionTitle, variant: TextVariant.headlineLarge, color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              CustomText(AppStaticStrings.roleSelectionDesc, variant: TextVariant.bodyMedium, color: AppColors.kGreyTextColor),
              const SizedBox(height: 40),
              RoleSelectionCard(
                title: AppStaticStrings.roleCustomerTitle,
                description: AppStaticStrings.roleCustomerDesc,
                icon: Icons.person_outline,
                isSelected: selectedRole == 'customer',
                onTap: () => ref.read(onboardingRoleProvider.notifier).selectRole('customer'),
              ),
              const SizedBox(height: 16),
              RoleSelectionCard(
                title: AppStaticStrings.roleShopOwnerTitle,
                description: AppStaticStrings.roleShopOwnerDesc,
                icon: Icons.storefront_outlined,
                isSelected: selectedRole == 'shop_owner',
                onTap: () => ref.read(onboardingRoleProvider.notifier).selectRole('shop_owner'),
              ),
              const Spacer(),
              CustomButton(
                text: AppStaticStrings.continueText,
                onPressed: () => context.push(AppRoutes.login),
                backgroundColor: selectedRole != null ? AppColors.kPrimaryColor : Colors.grey,
              ),
            ],
          ),
        ),
      );
    }

    // 3. WELCOME SCREEN (Step 4)
    if (step == 4) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(height: 60),
            SvgPicture.asset(AppStaticStrings.cupIcon, height: 32, colorFilter: const ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn)),
            const SizedBox(height: 8),
            CustomText(AppStaticStrings.appName, variant: TextVariant.titleLarge, color: AppColors.kPrimaryColor),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(AppStaticStrings.onboardingImg4, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  CustomText(AppStaticStrings.onboardingTitle4, variant: TextVariant.headlineLarge, color: AppColors.kPrimaryColor),
                  const SizedBox(height: 12),
                  CustomText(AppStaticStrings.onboardingDesc4, variant: TextVariant.bodyMedium, color: AppColors.kGreyTextColor, textAlign: TextAlign.center),
                  const SizedBox(height: 40),
                  CustomButton(text: AppStaticStrings.getStarted, onPressed: () => ref.read(onboardingStepProvider.notifier).setStep(5)),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.login),
                    child: CustomText(AppStaticStrings.alreadyHaveAccount, color: AppColors.kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // 4. ONBOARDING SLIDES (Steps 1, 2, 3)
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (i) => ref.read(onboardingStepProvider.notifier).setStep(i + 1),
            children: const [
              OnboardingSlide(imagePath: AppStaticStrings.onboardingImg1, title: AppStaticStrings.onboardingTitle1, description: AppStaticStrings.onboardingDesc1),
              OnboardingSlide(imagePath: AppStaticStrings.onboardingImg2, title: AppStaticStrings.onboardingTitle2, description: AppStaticStrings.onboardingDesc2),
              OnboardingSlide(imagePath: AppStaticStrings.onboardingImg3, title: AppStaticStrings.onboardingTitle3, description: AppStaticStrings.onboardingDesc3),
            ],
          ),
          Positioned(
            bottom: 40, left: 24, right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8, width: (step - 1) == index ? 24 : 8,
                    decoration: BoxDecoration(color: (step - 1) == index ? AppColors.kPrimaryColor : Colors.grey.shade300, borderRadius: BorderRadius.circular(4)),
                  )),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: AppStaticStrings.next,
                  onPressed: () {
                    if (step < 3) {
                      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                    } else {
                      ref.read(onboardingStepProvider.notifier).setStep(4);
                    }
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: AppStaticStrings.skip,
                  onPressed: () => ref.read(onboardingStepProvider.notifier).setStep(4),
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

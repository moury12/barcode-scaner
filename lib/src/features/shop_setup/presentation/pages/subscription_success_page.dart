import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class SubscriptionSuccessPage extends ConsumerWidget {
  const SubscriptionSuccessPage({super.key});

  String _getPlanTitle(ShopPlan plan) {
    switch (plan) {
      case ShopPlan.starter:
        return "Starter Plan";
      case ShopPlan.professional:
        return "Professional Plan";
      case ShopPlan.enterprise:
        return "Enterprise Plan";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(planProvider);
    final planTitle = _getPlanTitle(selectedPlan);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            children: [
              const Spacer(),
              // Teal / Green circle checkmark
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: AppColors.kSetupButtonColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
              space24H,
              const CustomText(
                AppStaticStrings.subscriptionActive,
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                "Your subscription has been activated successfully.\nYou are ready to configure your shop profile.",
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              space24H,
              // Status Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          planTitle,
                          variant: TextVariant.titleMedium,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              space4W,
                              const CustomText(
                                "Active",
                                variant: TextVariant.labelMedium,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          "Next Renewal",
                          color: AppColors.kBrownTextColor,
                        ),
                        const CustomText(
                          "Sept 30, 2026",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Set Up My Shop →",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () => context.push(AppRoutes.shopDetailsSetup),
              ),
              space12H,
            ],
          ),
        ),
      ),
    );
  }
}

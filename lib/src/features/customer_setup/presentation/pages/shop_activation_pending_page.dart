import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ShopActivationPendingPage extends ConsumerWidget {
  const ShopActivationPendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            children: [
              const Spacer(),
              // Circular progress graphic with a clock icon
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: AppColors.kYellowColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.access_time_filled,
                      color: AppColors.kPrimaryColor,
                      size: 36,
                    ),
                  ),
                ),
              ),
              space24H,
              const CustomText(
                "Activation Pending",
                variant: TextVariant.headlineMedium,
                fontWeight: FontWeight.bold,
              ),
              space8H,
              const CustomText(
                "Your request has been sent to the shop owner.\nPlease wait for them to confirm your membership.",
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
                        const CustomText(
                          "SELECTED SHOP",
                          variant: TextVariant.bodySmall,
                          color: AppColors.kBrownTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        const CustomText(
                          "Heritage Cafe",
                          variant: TextVariant.titleSmall,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          "REQUEST STATUS",
                          variant: TextVariant.bodySmall,
                          color: AppColors.kBrownTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              space4W,
                              const CustomText(
                                "Pending",
                                variant: TextVariant.labelMedium,
                                color: Colors.orange,
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
                          "REQUEST DATE",
                          variant: TextVariant.bodySmall,
                          color: AppColors.kBrownTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        const CustomText(
                          "Aug 31, 2026",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                text: AppStaticStrings.refreshStatus,
                backgroundColor: AppColors.kSetupButtonColor,
                icon: Icons.refresh,
                onPressed: () {
                  ref.read(customerSetupProvider.notifier).approveRequest();
                  context.push(AppRoutes.shopActivationSuccess);
                },
              ),
              space12H,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ChoosePlanPage extends ConsumerWidget {
  const ChoosePlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(planProvider);

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          AppStaticStrings.choosePlanTitle,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const CustomText(
                        "Select the right subscription plan for your shop's needs.",
                        textAlign: TextAlign.center,
                        color: AppColors.kBrownTextColor,
                      ),
                      space16H,
                      _buildPlanCard(
                        context: context,
                        ref: ref,
                        plan: ShopPlan.starter,
                        title: "Starter Plan",
                        price: "\$19",
                        period: "/month",
                        isRecommended: false,
                        isSelected: selectedPlan == ShopPlan.starter,
                        features: const [
                          "Daily code scanning up to 100",
                          "Basic customer management",
                          "Standard support",
                        ],
                      ),
                      space12H,
                      _buildPlanCard(
                        context: context,
                        ref: ref,
                        plan: ShopPlan.professional,
                        title: "Professional Plan",
                        price: "\$49",
                        period: "/month",
                        isRecommended: true,
                        isSelected: selectedPlan == ShopPlan.professional,
                        features: const [
                          "Unlimited daily code scanning",
                          "Advanced customer analytics",
                          "Redemption tracking & reports",
                          "Priority customer support",
                        ],
                      ),
                      space12H,
                      _buildPlanCard(
                        context: context,
                        ref: ref,
                        plan: ShopPlan.enterprise,
                        title: "Enterprise Plan",
                        price: "\$99",
                        period: "/month",
                        isRecommended: false,
                        isSelected: selectedPlan == ShopPlan.enterprise,
                        features: const [
                          "All Professional features",
                          "Multi-location support",
                          "Dedicated account manager",
                          "Custom integration & API access",
                        ],
                      ),
                      space16H,
                    ],
                  ),
                ),
              ),
              space12H,
              CustomButton(
                text: "CONTINUE →",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () => context.push(AppRoutes.subscriptionPayment),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required WidgetRef ref,
    required ShopPlan plan,
    required String title,
    required String price,
    required String period,
    required bool isRecommended,
    required bool isSelected,
    required List<String> features,
  }) {
    return GestureDetector(
      onTap: () => ref.read(planProvider.notifier).selectPlan(plan),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppColors.kSetupButtonColor
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.kSetupButtonColor.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title,
                          variant: TextVariant.titleMedium,
                          fontWeight: FontWeight.bold,
                        ),
                        space4H,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            CustomText(
                              price,
                              variant: TextVariant.headlineMedium,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                            CustomText(
                              period,
                              variant: TextVariant.bodySmall,
                              color: AppColors.kBrownTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Radio<ShopPlan>(
                      value: plan,
                      groupValue: ref.watch(planProvider),
                      activeColor: AppColors.kSetupButtonColor,
                      onChanged: (val) {
                        if (val != null) {
                          ref.read(planProvider.notifier).selectPlan(val);
                        }
                      },
                    ),
                  ],
                ),
                const Divider(height: 24),
                ...features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: AppColors.kSetupButtonColor,
                        ),
                        space8W,
                        Expanded(
                          child: CustomText(
                            feature,
                            variant: TextVariant.bodyMedium,
                            color: AppColors.kBrownTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isRecommended)
            Positioned(
              top: -10,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.kAccentColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CustomText(
                  "Recommended",
                  variant: TextVariant.labelMedium,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

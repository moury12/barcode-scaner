import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class SubscriptionPaymentPage extends ConsumerWidget {
  const SubscriptionPaymentPage({super.key});

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

  double _getPlanPrice(ShopPlan plan) {
    switch (plan) {
      case ShopPlan.starter:
        return 19.0;
      case ShopPlan.professional:
        return 49.0;
      case ShopPlan.enterprise:
        return 99.0;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(planProvider);
    final planTitle = _getPlanTitle(selectedPlan);
    final price = _getPlanPrice(selectedPlan);
    final tax = price * 0.1;
    final total = price + tax;

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
          AppStaticStrings.completeSubscription,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Plan Summary Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  planTitle,
                                  variant: TextVariant.titleMedium,
                                  fontWeight: FontWeight.bold,
                                ),
                                space4H,
                                const CustomText(
                                  "Billed monthly",
                                  variant: TextVariant.bodySmall,
                                  color: AppColors.kBrownTextColor,
                                ),
                              ],
                            ),
                            CustomText(
                              "\$${price.toStringAsFixed(0)}/mo",
                              variant: TextVariant.titleLarge,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      space16H,
                      const CustomText(
                        "Payment Details",
                        variant: TextVariant.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                      space12H,
                      // Credit Card Selector Option Card
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.kSetupButtonColor),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.credit_card, color: AppColors.kSetupButtonColor),
                            space12W,
                            const CustomText(
                              "Credit / Debit Card",
                              variant: TextVariant.bodyMedium,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            const Icon(Icons.check_circle, color: AppColors.kSetupButtonColor, size: 20),
                          ],
                        ),
                      ),
                      space16H,
                      const CustomTextField(
                        title: "Cardholder Name",
                        hintText: "e.g. John Doe",
                      ),
                      space12H,
                      const CustomTextField(
                        title: "Card Number",
                        hintText: "1234 5678 9012 3456",
                        keyboardType: TextInputType.number,
                        prefixIcon: Icon(Icons.credit_card, size: 20),
                      ),
                      space12H,
                      Row(
                        children: [
                          Expanded(
                            child: const CustomTextField(
                              title: "Expiry Date",
                              hintText: "MM/YY",
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          space12W,
                          Expanded(
                            child: const CustomTextField(
                              title: "CVC",
                              hintText: "123",
                              keyboardType: TextInputType.number,
                              isPassword: true,
                            ),
                          ),
                        ],
                      ),
                      space24H,
                      // Order Summary
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText("Subtotal", color: AppColors.kBrownTextColor),
                                CustomText("\$${price.toStringAsFixed(2)}", fontWeight: FontWeight.w600),
                              ],
                            ),
                            space8H,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText("Estimated Tax (10%)", color: AppColors.kBrownTextColor),
                                CustomText("\$${tax.toStringAsFixed(2)}", fontWeight: FontWeight.w600),
                              ],
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText("Total", variant: TextVariant.titleMedium, fontWeight: FontWeight.bold),
                                CustomText(
                                  "\$${total.toStringAsFixed(2)}",
                                  variant: TextVariant.titleLarge,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      space16H,
                    ],
                  ),
                ),
              ),
              space12H,
              CustomButton(
                text: "Subscribe Now →",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () => context.push(AppRoutes.subscriptionSuccess),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

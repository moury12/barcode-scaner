import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ShopDetailsPage extends ConsumerWidget {
  const ShopDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Banner Image with Back Button Overlay
                  Stack(
                    children: [
                      SizedBox(
                        height: 220,
                        width: double.infinity,
                        child: Image.asset(
                          AppStaticStrings.onboardingImg1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withValues(alpha: 0.4),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => context.pop(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Content Area
                  Transform.translate(
                    offset: const Offset(0, -20),
                    child: Container(
                      padding: AppPadding.getPadding16(context),
                      decoration: const BoxDecoration(
                        color: AppColors.kBackgroundColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                "Heritage Cafe",
                                variant: TextVariant.headlineLarge,
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.kYellowColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const CustomText(
                                  "PARTICIPATING",
                                  fontSize: 10,
                                  color: AppColors.kAccentColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          space4H,
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: AppColors.kBrownTextColor,
                              ),
                              space4W,
                              const CustomText(
                                "Marylebone, London • 0.4 miles away",
                                color: AppColors.kBrownTextColor,
                                variant: TextVariant.bodySmall,
                              ),
                            ],
                          ),
                          space12H,
                          const CustomText(
                            "Specialty coffee shop bringing hand-crafted espresso, single-origin roasts, and organic pastries to your daily routine. Relax in our warm ambiance.",
                            color: AppColors.kBrownTextColor,
                            maxLines: 3,
                          ),
                          space16H,
                          // Tag Capsules
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _tagCapsule("Vegan Options"),
                              _tagCapsule("Wifi"),
                              _tagCapsule("Outdoor Seating"),
                            ],
                          ),
                          space16H,
                          // Daily Drink Benefit Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8F0),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.kYellowColor.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.kYellowColor.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.card_giftcard,
                                    color: AppColors.kAccentColor,
                                    size: 24,
                                  ),
                                ),
                                space12W,
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        "Daily Drink Benefit",
                                        variant: TextVariant.titleSmall,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      space2H,
                                      CustomText(
                                        "Get 1 complimentary hot or cold drink every single day when active.",
                                        variant: TextVariant.bodySmall,
                                        color: AppColors.kBrownTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          space16H,
                          // Opening Hours
                          const CustomText(
                            "Opening Hours",
                            variant: TextVariant.titleMedium,
                            fontWeight: FontWeight.bold,
                          ),
                          space8H,
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              children: [
                                _hoursRow("Monday - Friday", "7:00 AM - 6:00 PM"),
                                const Divider(height: 16),
                                _hoursRow("Saturday", "8:00 AM - 6:00 PM"),
                                const Divider(height: 16),
                                _hoursRow("Sunday", "8:00 AM - 5:00 PM"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer Action Button
          Container(
            padding: AppPadding.getPadding12(context),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                text: "Join This Shop →",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: () {
                  ref.read(customerSetupProvider.notifier).sendRequest();
                  context.push(AppRoutes.shopActivationPending);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagCapsule(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        label,
        variant: TextVariant.bodySmall,
        fontWeight: FontWeight.w500,
        color: AppColors.kTextColor,
      ),
    );
  }

  Widget _hoursRow(String day, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          day,
          variant: TextVariant.bodyMedium,
          color: AppColors.kBrownTextColor,
        ),
        CustomText(
          time,
          variant: TextVariant.bodyMedium,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ShopDetailsPage extends ConsumerWidget {
  const ShopDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          "Shop Details",
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
          color: Color(0xFF536148),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 12,
                children: [
                  const ShopDetailsBanner(
                    imageUrl:
                        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=1000",
                  ),
                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: Container(
                      padding: AppPadding.getPadding12(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        spacing: 12,
                        children: [
                          const ShopProfileHeader(
                            shopName: "Heritage & Hearth",
                            location: "Marylebone, London",
                          ),

                          const CustomText(
                            "A sanctuary for coffee lovers, specializing in artisanal roasts and hand-crafted pastries in the heart of London.",
                            textAlign: TextAlign.center,
                            color: AppColors.kBrownTextColor,
                            variant: TextVariant.bodyMedium,
                            height: 1.5,
                          ),

                          const ShopFeatureTags(
                            tags: ["Vegan Options", "Wifi", "Outdoor Seating"],
                          ),

                          const BenefitCard(),

                          const OpeningHoursCard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppPadding.getPadding12(context),
            child: CustomButton(
              text: "Join This Shop →",
              backgroundColor: const Color(0xFF536148),
              onPressed: () => context.push(AppRoutes.shopActivationPending),
            ),
          ),
        ],
      ),
    );
  }
}

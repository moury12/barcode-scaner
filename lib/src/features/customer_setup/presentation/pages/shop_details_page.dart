import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ShopDetailsPage extends ConsumerStatefulWidget {
  final String shopId;
  const ShopDetailsPage({super.key, required this.shopId});

  @override
  ConsumerState<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends ConsumerState<ShopDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shopDetailProvider.notifier).load(widget.shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(shopDetailProvider);

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
      body: detailState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : detailState.errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    space12H,
                    CustomText(
                      detailState.errorMessage ?? 'An error occurred',
                      textAlign: TextAlign.center,
                      color: AppColors.kBrownTextColor,
                    ),
                    space16H,
                    CustomButton(
                      text: 'Retry',
                      backgroundColor: AppColors.kPrimaryColor,
                      onPressed: () => ref
                          .read(shopDetailProvider.notifier)
                          .load(widget.shopId),
                    ),
                  ],
                ),
              ),
            )
          : detailState.shop == null
          ? const Center(child: CustomText("Shop not found"))
          : _buildBody(context, ref, detailState),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    ShopDetailState detailState,
  ) {
    final shop = detailState.shop!;

    // Map opening hours format
    final List<Map<String, String>> hoursList = shop.openingHours.map((h) {
      return {
        "day": h.day,
        "time": h.isClosed ? "Closed" : "${h.openTime} - ${h.closeTime}",
      };
    }).toList();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                ShopDetailsBanner(imageUrl: shop.image),
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
                        ShopProfileHeader(
                          shopName: shop.name,
                          location: shop.address,
                          description: shop.description,
                        ),
                        CustomText(
                          shop.description,
                          textAlign: TextAlign.center,
                          color: AppColors.kBrownTextColor,
                          variant: TextVariant.bodyMedium,
                          height: 1.5,
                        ),
                        if (shop.dailyBenefitDescription.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomText(
                              shop.dailyBenefitDescription,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        // const ShopFeatureTags(
                        //   tags: ["Vegan Options", "Wifi", "Outdoor Seating"],
                        // ),
                        const BenefitCard(),
                        OpeningHoursCard(
                          hours: hoursList.isNotEmpty ? hoursList : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (detailState.successMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomText(
              detailState.successMessage!,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        Padding(
          padding: AppPadding.getPadding12(context),
          child: shop.isJoin
              ? CustomButton(
                  text: shop.membershipStatus == 'pending'
                      ? "Request Pending"
                      : "Already Joined",
                  backgroundColor: Colors.grey,
                  onPressed: () {}, // Disabled
                )
              : CustomButton(
                  text: detailState.isJoining
                      ? "Joining..."
                      : "Join This Shop →",
                  backgroundColor: const Color(0xFF536148),
                  onPressed: detailState.isJoining
                      ? null
                      : () => ref
                            .read(shopDetailProvider.notifier)
                            .joinShop(widget.shopId),
                ),
        ),
      ],
    );
  }
}

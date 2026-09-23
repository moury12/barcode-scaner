import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../src_export.dart';
import '../../../shop_setup/data/models/shop_model.dart';

class ShopProfileTab extends ConsumerStatefulWidget {
  const ShopProfileTab({super.key});

  @override
  ConsumerState<ShopProfileTab> createState() => _ShopProfileTabState();
}

class _ShopProfileTabState extends ConsumerState<ShopProfileTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shopControllerProvider.notifier).fetchMyShop();
      ref.read(openingHourControllerProvider.notifier).fetchOpeningHours();
    });
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            space8W,
            CustomText(
              'Log Out',
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ],
        ),
        content: const CustomText(
          'Are you sure you want to log out?',
          color: AppColors.kBrownTextColor,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const CustomText('Cancel', color: AppColors.kBrownTextColor),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const CustomText(
              'Log Out',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    final success = await ref
        .read(profileActionControllerProvider.notifier)
        .logout();
    if (!mounted) return;

    if (success) {
      context.go(AppRoutes.login);
    } else {
      final err = ref.read(profileActionControllerProvider).errorMessage;
      CustomSnackbar.show(context, err ?? 'Logout failed', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopState = ref.watch(shopControllerProvider);
    final hoursState = ref.watch(openingHourControllerProvider);
    final shop = shopState.shop;

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.appName,
          variant: TextVariant.titleLarge,
        ),
      ),
      body: shopState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                ref.read(shopControllerProvider.notifier).fetchMyShop();
                ref
                    .read(openingHourControllerProvider.notifier)
                    .fetchOpeningHours();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: AppPadding.getPadding12(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      "Profile",
                      variant: TextVariant.headlineMedium,
                      fontWeight: FontWeight.bold,
                    ),
                    space8H,

                    // ─── Shop Card ───
                    if (shop != null)
                      _shopHeaderCard(shop)
                    else
                      SizedBox.shrink(),

                    space8H,

                    ProfileMenuItem(
                      icon: Icons.qr_code,
                      title: "Show Qr Code",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text("Shop QR Code"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    shop!.qrCode!,
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 16),

                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white,
                                    ),
                                    height: 300,
                                    width: 300,
                                    child: QrImageView(
                                      data: shop.qrCode!,
                                      version: QrVersions.auto,
                                      size: 190,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: const Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    space8H,
                    ProfileMenuItem(
                      icon: Icons.storefront,
                      title: "Shop Profile",
                      onTap: () => context.push(
                        AppRoutes.shopDetailsSetup,
                        extra: {'isEditing': shop != null},
                      ),
                    ),

                    // ─── Opening Hours ───
                    space8H,
                    _openingHoursSection(hoursState),

                    space8H,
                    ProfileMenuItem(
                      icon: Icons.history,
                      title: "Redemption History",
                      onTap: () => context.push(AppRoutes.redemptionHistory),
                    ),
                    space8H,
                    const ProfileMenuItem(
                      icon: Icons.credit_card,
                      title: "Current Plan",
                    ),
                    space8H,
                    ProfileMenuItem(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      onTap: () => context.push(AppRoutes.helpSupport),
                    ),
                    space8H,
                    ProfileMenuItem(
                      icon: Icons.description_outlined,
                      title: "Terms & Conditions",
                      onTap: () => context.push(AppRoutes.termsCondition),
                    ),
                    space8H,
                    ProfileMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () => context.push(AppRoutes.privacyPolicy),
                    ),
                    space24H,
                    ProfileMenuItem(
                      icon: Icons.logout,
                      title: "Log Out",
                      isDestructive: true,
                      onTap: _handleLogout,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _shopHeaderCard(ShopModel shop) {
    final statusColor = shop.status == 'active'
        ? Colors.green
        : shop.status == 'pending'
        ? Colors.orange
        : Colors.grey;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: shop.image != null && shop.image!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      shop.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.storefront,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Icon(Icons.storefront, size: 32, color: Colors.grey),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  shop.name,
                  variant: TextVariant.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
                if (shop.address != null && shop.address!.isNotEmpty) ...[
                  space2H,
                  CustomText(
                    shop.address!,
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                  ),
                ],
                if (shop.contactNumber != null &&
                    shop.contactNumber!.isNotEmpty) ...[
                  space2H,
                  CustomText(
                    shop.contactNumber!,
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: CustomText(
              shop.status.toUpperCase(),
              variant: TextVariant.labelSmall,
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _openingHoursSection(OpeningHourState hoursState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                'Opening Hours',
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              ButtonTapWidget(
                onTap: () => context.push(AppRoutes.openingHours),
                child: const CustomText(
                  '+ Add',
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  variant: TextVariant.labelMedium,
                ),
              ),
            ],
          ),
          space12H,
          if (hoursState.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (hoursState.hours.isEmpty)
            const CustomText(
              'No opening hours set yet.',
              color: AppColors.kBrownTextColor,
              variant: TextVariant.bodySmall,
            )
          else
            ...hoursState.hours.map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.kPrimaryColor,
                    ),
                    space8W,
                    Expanded(
                      child: CustomText(
                        h.day,
                        variant: TextVariant.bodySmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomText(
                      '${h.openTime} – ${h.closeTime}',
                      variant: TextVariant.bodySmall,
                      color: AppColors.kBrownTextColor,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

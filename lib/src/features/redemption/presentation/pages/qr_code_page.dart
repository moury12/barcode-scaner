import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../src_export.dart';
import '../../../customer_setup/data/datasources/customer_shop_remote_datasource.dart';

class QrCodePage extends ConsumerStatefulWidget {
  const QrCodePage({super.key});

  @override
  ConsumerState<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends ConsumerState<QrCodePage> {
  bool _isLoading = false;
  String? _qrCode;
  String? _expiresAt;
  String? _errorMessage;
  String? _fetchedShopId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQrCode();
    });
  }

  Future<void> _loadQrCode({bool forceRefresh = false}) async {
    final selectedMembership = ref.read(selectedMembershipProvider);
    final shopId = selectedMembership?.shopId;

    if (shopId == null || shopId.isEmpty) {
      setState(() {
        _errorMessage = 'No active shop membership selected.';
        _isLoading = false;
      });
      return;
    }

    if (!forceRefresh && _fetchedShopId == shopId && _qrCode != null) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final ds = ref.read(customerShopRemoteDataSourceProvider);
      final res = await ds.generateQrCode(shopId);

      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _qrCode = res['qrCode'] as String?;
        _expiresAt = res['expiresAt'] as String?;
        _fetchedShopId = shopId;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  String _formatExpiration(String? expiresAtStr) {
    if (expiresAtStr == null) return "Valid today";
    final dt = DateTime.tryParse(expiresAtStr);
    if (dt == null) return "Valid today";

    final now = DateTime.now();
    final diff = dt.difference(now);
    if (diff.isNegative) {
      return "Expired";
    }

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    if (hours > 0) {
      return "Expires in ${hours}h ${minutes}m";
    } else {
      return "Expires in ${minutes}m";
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedMembership = ref.watch(selectedMembershipProvider);

    // If selected membership changes, refresh code
    if (selectedMembership != null &&
        selectedMembership.shopId != _fetchedShopId &&
        !_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadQrCode(forceRefresh: true);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "My Daily Code",
          variant: TextVariant.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadQrCode(forceRefresh: true),
            tooltip: "Refresh QR Code",
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding24(context),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding24(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Small Shop Information Header
                  if (selectedMembership != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: selectedMembership.image.isNotEmpty
                              ? CustomNetworkImage(
                                  imageUrl: selectedMembership.image,
                                  height: 40,
                                  width: 40,
                                  radius: 20,
                                )
                              : Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.storefront,
                                    size: 22,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                        ),
                        space12W,
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                selectedMembership.shopName,
                                variant: TextVariant.titleMedium,
                                fontWeight: FontWeight.bold,
                                maxLines: 1,
                              ),
                              if (selectedMembership.address.isNotEmpty)
                                CustomText(
                                  selectedMembership.address,
                                  variant: TextVariant.bodySmall,
                                  color: AppColors.kBrownTextColor,
                                  maxLines: 1,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    space16H,
                  ],

                  if (_qrCode != null) ...[
                    CustomText(
                      "CODE: $_qrCode",
                      variant: TextVariant.titleMedium,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimaryColor,
                    ),
                    space8H,
                  ],

                  _validBadge(_formatExpiration(_expiresAt)),
                  space24H,

                  // QR Frame
                  if (_isLoading)
                    const AppLoader(height: 200, width: 200)
                  else if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          space12H,
                          CustomText(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            color: AppColors.kBrownTextColor,
                          ),
                          space16H,
                          CustomButton(
                            text: "Try Again",
                            onPressed: () => _loadQrCode(forceRefresh: true),
                          ),
                        ],
                      ),
                    )
                  else if (_qrCode != null)
                    ButtonTapWidget(
                      onTap: () {
                        context.push(AppRoutes.redemptionSuccess);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: QrImageView(
                          data: _qrCode!,
                          version: QrVersions.auto,
                          size: 190.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  else
                    const CustomText("No QR Code generated yet."),

                  space24H,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(icon: Icons.coffee, label: "1 Drink / Day"),
                      _StatItem(
                        icon: Icons.timer_outlined,
                        label: "Valid 24 Hours",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            space24H,
            const CustomText(
              "This code is generated securely for your account and updates every 24 hours.",
              color: AppColors.kBrownTextColor,
              variant: TextVariant.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _validBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF5E6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text.toUpperCase(),
        fontSize: 11,
        color: const Color(0xFFB37D4E),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _StatItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF536148)),
        space4H,
        CustomText(
          label,
          variant: TextVariant.labelSmall,
          color: AppColors.kBrownTextColor,
        ),
      ],
    );
  }
}

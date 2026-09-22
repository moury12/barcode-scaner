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
  bool _isCheckingRedeemed = false;
  String? _qrCode;
  String? _expiresAt;
  String? _errorMessage;
  String? _fetchedShopId;
  bool? _isRedeemed; // null = not checked yet

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
      _isRedeemed = null;
    });

    try {
      final ds = ref.read(customerShopRemoteDataSourceProvider);
      final res = await ds.generateQrCode(shopId);

      if (!mounted) return;

      final newQrCode = res['qrCode'] as String?;
      setState(() {
        _isLoading = false;
        _qrCode = newQrCode;
        _expiresAt = res['expiresAt'] as String?;
        _fetchedShopId = shopId;
      });

      // Now check if this QR is already redeemed
      if (newQrCode != null) {
        _fetchRedeemedStatus(newQrCode);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _fetchRedeemedStatus(String qrCode) async {
    if (!mounted) return;
    setState(() => _isCheckingRedeemed = true);

    try {
      final api = ref.read(apiServiceProvider);
      final response = await api.get('/redemption/single-redemption/$qrCode');

      if (!mounted) return;
      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>?;
        setState(() {
          _isRedeemed = data?['isRedeemed'] as bool? ?? false;
          _isCheckingRedeemed = false;
        });
        return;
      }
    } catch (_) {}

    if (mounted) setState(() => _isCheckingRedeemed = false);
  }

  String _formatExpiration(String? expiresAtStr) {
    if (expiresAtStr == null) return "Valid today";
    final dt = DateTime.tryParse(expiresAtStr);
    if (dt == null) return "Valid today";

    final now = DateTime.now();
    final diff = dt.difference(now);
    if (diff.isNegative) return "Expired";

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return hours > 0
        ? "Expires in ${hours}h ${minutes}m"
        : "Expires in ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    final selectedMembership = ref.watch(selectedMembershipProvider);
    final memberships = ref.watch(myMembershipsProvider).memberships;

    // Reload when selected shop changes
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
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadQrCode(forceRefresh: true),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: AppPadding.getPadding24(context),
          child: Column(
            children: [
              // ── Shop Selector Dropdown ──────────────────────────────
              if (memberships.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedMembership?.shopId,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.storefront_outlined,
                        color: AppColors.kPrimaryColor,
                      ),
                      hint: const CustomText(
                        'Select Shop',
                        color: AppColors.kBrownTextColor,
                      ),
                      items: memberships
                          .map(
                            (m) => DropdownMenuItem<String>(
                              value: m.shopId,
                              child: CustomText(
                                m.shopName,
                                variant: TextVariant.bodyMedium,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (shopId) {
                        if (shopId == null) return;
                        final m = memberships.firstWhere(
                          (m) => m.shopId == shopId,
                        );
                        ref
                            .read(myMembershipsProvider.notifier)
                            .selectMembership(m);
                      },
                    ),
                  ),
                ),

              space16H,

              // ── QR Card ─────────────────────────────────────────────
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
                    // Shop header
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

                    // QR Code label
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
                    space12H,

                    // isRedeemed status badge
                    if (_isCheckingRedeemed)
                      const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _redeemedBadge(_isRedeemed ?? false),
                          const SizedBox(width: 6),
                          // Tap to re-check status without generating new QR
                          GestureDetector(
                            onTap: _qrCode != null
                                ? () => _fetchRedeemedStatus(_qrCode!)
                                : null,
                            child: const Icon(
                              Icons.refresh,
                              size: 18,
                              color: AppColors.kBrownTextColor,
                            ),
                          ),
                        ],
                      ),

                    space16H,

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
                          ],
                        ),
                      )
                    else if (_qrCode != null)
                      Container(
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
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: const CustomText("No QR Code generated yet."),
                      ),

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

                    space20H,

                    // Generate New Code button (replaces the old refresh icon)
                    CustomButton(
                      text: "Generate New Code",
                      backgroundColor: const Color(0xFF25160E),
                      icon: Icons.qr_code_2,
                      isLoading: _isLoading,
                      onPressed: _isLoading
                          ? null
                          : () => _loadQrCode(forceRefresh: true),
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

  Widget _redeemedBadge(bool isRedeemed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isRedeemed ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isRedeemed ? Colors.red.shade200 : Colors.green.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isRedeemed ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 14,
            color: isRedeemed ? Colors.red.shade600 : Colors.green.shade600,
          ),
          const SizedBox(width: 6),
          CustomText(
            isRedeemed ? 'ALREADY REDEEMED' : 'NOT YET REDEEMED',
            fontSize: 11,
            color: isRedeemed ? Colors.red.shade600 : Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
        ],
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class CustomerVerifiedPage extends ConsumerStatefulWidget {
  final String? qrCode;
  const CustomerVerifiedPage({super.key, this.qrCode});

  @override
  ConsumerState<CustomerVerifiedPage> createState() =>
      _CustomerVerifiedPageState();
}

class _CustomerVerifiedPageState extends ConsumerState<CustomerVerifiedPage> {
  bool _isLoading = false;
  String? _errorMessage;

  // Parsed fields from single-redemption response (shop owner view)
  String? _customerName;
  String? _customerEmail;
  String? _customerPhone;
  String? _customerImg;
  bool _isRedeemed = false;
  String? _expiresAt;
  String? _qrCodeValue;

  @override
  void initState() {
    super.initState();
    _qrCodeValue = widget.qrCode;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_qrCodeValue != null && _qrCodeValue!.isNotEmpty) {
        _fetchRedemptionDetails();
      }
    });
  }

  Future<void> _fetchRedemptionDetails() async {
    if (_qrCodeValue == null || _qrCodeValue!.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final api = ref.read(apiServiceProvider);
      final response =
          await api.get('/redemption/single-redemption/$_qrCodeValue');

      if (!mounted) return;

      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            _isLoading = false;
            _customerName = data['customerName'] as String?;
            _customerEmail = data['customerEmail'] as String?;
            _customerPhone = data['customerPhone'] as String?;
            _customerImg = data['customerImg'] as String?;
            _isRedeemed = data['isRedeemed'] as bool? ?? false;
            _expiresAt = data['expiresAt'] as String?;
          });
          return;
        }
      }

      final msg =
          (response.data is Map && response.data['message'] != null)
              ? response.data['message']
              : 'Failed to load redemption details';
      setState(() {
        _isLoading = false;
        _errorMessage = msg;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  String _formatExpiry(String? expiresAtStr) {
    if (expiresAtStr == null) return 'Midnight';
    final dt = DateTime.tryParse(expiresAtStr);
    if (dt == null) return 'Midnight';
    final now = DateTime.now();
    if (dt.isBefore(now)) return 'Expired';
    final diff = dt.difference(now);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    return hours > 0 ? '${hours}h ${minutes}m left' : '${minutes}m left';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          "Customer Verified",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: _isLoading
            ? const Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: CircularProgressIndicator(),
              ))
            : _errorMessage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        const Icon(Icons.error_outline,
                            size: 48, color: Colors.red),
                        space12H,
                        CustomText(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                          color: AppColors.kBrownTextColor,
                        ),
                        space16H,
                        CustomButton(
                          text: 'Retry',
                          onPressed: _fetchRedemptionDetails,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      CustomerVerificationCard(
                        customerName: _customerName ?? 'Unknown Customer',
                        memberStatus: _isRedeemed ? 'Redeemed' : 'Active Member',
                        plan: 'Daily Brew Pass',
                        resetTime: _formatExpiry(_expiresAt),
                        customerImg: _customerImg,
                        customerEmail: _customerEmail,
                        customerPhone: _customerPhone,
                        isRedeemed: _isRedeemed,
                      ),
                      space24H,
                      if (!_isRedeemed)
                        CustomButton(
                          text: "Confirm Redemption",
                          backgroundColor: const Color(0xFF25160E),
                          icon: Icons.check,
                          onPressed: () =>
                              context.push(AppRoutes.redemptionSuccess),
                        ),
                      if (_isRedeemed)
                        CustomButton(
                          text: "Already Redeemed",
                          backgroundColor: Colors.red.shade400,
                          icon: Icons.block,
                          onPressed: null,
                        ),
                      space8H,
                      CustomButton(
                        text: "Cancel",
                        isOutlined: true,
                        borderColor: Colors.grey.shade300,
                        textColor: AppColors.kTextColor,
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
      ),
    );
  }
}

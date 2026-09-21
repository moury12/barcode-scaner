import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ManualCodeEntryPage extends ConsumerStatefulWidget {
  final String? initialCode;

  const ManualCodeEntryPage({super.key, this.initialCode});

  @override
  ConsumerState<ManualCodeEntryPage> createState() => _ManualCodeEntryPageState();
}

class _ManualCodeEntryPageState extends ConsumerState<ManualCodeEntryPage> {
  late TextEditingController _codeController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.initialCode ?? '');
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      CustomSnackbar.show(context, 'Please enter a valid QR code', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final api = ref.read(apiServiceProvider);
      final response = await api.post(
        '/redemption/verify-qr-code',
        data: {'qrCode': code},
      );

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (response.data != null && response.data['success'] == true) {
        CustomSnackbar.show(
          context,
          response.data['message'] as String? ?? 'QR code verified successfully',
          isError: false,
        );
        context.push(AppRoutes.verifyRedemption);
      } else {
        final msg = (response.data is Map && response.data['message'] != null)
            ? response.data['message']
            : 'Failed to verify QR code';
        CustomSnackbar.show(context, msg, isError: true);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      final msg = e.toString().replaceAll('Exception: ', '');
      CustomSnackbar.show(context, msg, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const CustomText("Redeem Code", variant: TextVariant.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            space16H,
            const CustomText(
              "Enter Customer Code",
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            space8H,
            const CustomText(
              "Enter the code shown by the customer to verify their order.",
              textAlign: TextAlign.center,
              color: AppColors.kBrownTextColor,
            ),
            space24H,
            CustomTextField(
              textEditingController: _codeController,
              hintText: "HH-COFFEE-XXXXXX",
              textAlign: TextAlign.center,
            ),
            space24H,
            CustomButton(
              text: "Verify Code",
              isLoading: _isLoading,
              backgroundColor: const Color(0xFF25160E),
              onPressed: _isLoading ? null : _handleVerify,
            ),
            space8H,
            CustomButton(
              text: "Scan Instead",
              isOutlined: true,
              icon: Icons.qr_code_scanner,
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

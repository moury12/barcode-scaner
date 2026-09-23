import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../src_export.dart';
import '../../data/datasources/customer_shop_remote_datasource.dart';

class ScanShopQrPage extends ConsumerStatefulWidget {
  const ScanShopQrPage({super.key});

  @override
  ConsumerState<ScanShopQrPage> createState() => _ScanShopQrPageState();
}

class _ScanShopQrPageState extends ConsumerState<ScanShopQrPage> {
  late final MobileScannerController _scannerController;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  // ── Core API call ──────────────────────────────────────────────────────────
  Future<void> _joinWithCode(String qrCode) async {
    if (_isProcessing) return;

    final code = qrCode.trim().toUpperCase();
    if (code.isEmpty) {
      CustomSnackbar.show(
        context,
        'Please enter a valid QR code',
        isError: true,
      );
      return;
    }

    setState(() => _isProcessing = true);
    try {
      await _scannerController.stop();
    } catch (_) {}

    try {
      final ds = ref.read(customerShopRemoteDataSourceProvider);
      final result = await ds.joinShopWithQrCode(code);

      if (!mounted) return;

      final message =
          result['message'] as String? ?? 'Join request sent successfully.';
      final data = result['data'] as Map<String, dynamic>?;
      final status = data?['status'] as String? ?? 'pending';

      _showResultSheet(message: message, status: status);
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceAll('Exception: ', '');
      _showResultSheet(message: msg, status: 'error');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  // ── Result bottom sheet ────────────────────────────────────────────────────
  void _showResultSheet({required String message, required String status}) {
    final isError = status == 'error';
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isError
                        ? Colors.red.shade50
                        : status == 'pending'
                        ? Colors.orange.shade50
                        : Colors.green.shade50,
                  ),
                  child: Icon(
                    isError
                        ? Icons.error_outline
                        : status == 'pending'
                        ? Icons.hourglass_top_rounded
                        : Icons.check_circle_outline,
                    size: 36,
                    color: isError
                        ? Colors.red.shade600
                        : status == 'pending'
                        ? Colors.orange.shade700
                        : Colors.green.shade600,
                  ),
                ),
                space16H,
                CustomText(
                  isError
                      ? 'Notice'
                      : status == 'pending'
                      ? 'Request Sent!'
                      : 'Joined Successfully!',
                  variant: TextVariant.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
                space8H,
                CustomText(
                  message,
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                  variant: TextVariant.bodyMedium,
                ),
                space24H,
                CustomButton(
                  text: isError ? 'Go Back' : 'Done',
                  backgroundColor: isError
                      ? Colors.red.shade600
                      : AppColors.kPrimaryColor,
                  onPressed: () async {
                    Navigator.of(ctx).pop();

                    await Future<void>.delayed(Duration.zero);

                    if (!mounted) return;

                    if (!isError) {
                      await ref
                          .read(myMembershipsProvider.notifier)
                          .fetchMyMemberships();

                      if (!mounted) return;

                      context.pop();
                    } else {
                      try {
                        _scannerController.start();
                      } catch (_) {}
                    }
                  },
                ),
                if (!isError) ...[
                  space12H,
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      context.go(AppRoutes.mainLayout);
                    },
                    child: const CustomText(
                      'Go to home',
                      color: AppColors.kBrownTextColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Manual entry bottom sheet ──────────────────────────────────────────────
  void _showManualEntry() {
    try {
      _scannerController.stop();
    } catch (_) {}

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return _ManualCodeBottomSheet(
          onSubmit: (code) {
            if (code.isNotEmpty) {
              _joinWithCode(code);
            } else {
              if (mounted) {
                try {
                  _scannerController.start();
                } catch (_) {}
              }
            }
          },
          onCancel: () {
            if (mounted) {
              try {
                _scannerController.start();
              } catch (_) {}
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          AppStaticStrings.scanShopQr,
          variant: TextVariant.titleLarge,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          // Flash toggle
          ValueListenableBuilder(
            valueListenable: _scannerController,
            builder: (context, state, _) {
              final torchOn = state.torchState == TorchState.on;
              return IconButton(
                icon: Icon(
                  torchOn ? Icons.flash_on : Icons.flash_off,
                  color: torchOn ? Colors.yellow : Colors.grey,
                ),
                onPressed: () => _scannerController.toggleTorch(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // ── Live camera ──────────────────────────────────────────────────
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              if (_isProcessing) return;
              for (final barcode in capture.barcodes) {
                final raw = barcode.rawValue;
                if (raw != null && raw.isNotEmpty) {
                  _joinWithCode(raw);
                  break;
                }
              }
            },
          ),

          // ── Scanner overlay ──────────────────────────────────────────────
          _ScanOverlay(),

          // ── Processing overlay ───────────────────────────────────────────
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // ── Bottom buttons ───────────────────────────────────────────────
          Positioned(
            left: 12,
            right: 12,
            bottom: 24,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CustomText(
                    'Point your camera at the shop\'s QR code',
                    color: Colors.white70,
                    variant: TextVariant.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  space12H,
                  CustomButton(
                    text: 'Enter Code Manually',
                    isOutlined: true,
                    borderColor: Colors.white70,
                    textColor: Colors.white,
                    icon: Icons.keyboard_outlined,
                    iconColor: Colors.white,
                    onPressed: _isProcessing ? null : _showManualEntry,
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

/// Dedicated Stateful Widget for Manual Entry Bottom Sheet
/// Ensures `TextEditingController` lifecycle is strictly tied to the widget tree
class _ManualCodeBottomSheet extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  final VoidCallback onCancel;

  const _ManualCodeBottomSheet({
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  State<_ManualCodeBottomSheet> createState() => _ManualCodeBottomSheetState();
}

class _ManualCodeBottomSheetState extends State<_ManualCodeBottomSheet> {
  late final TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 28,
          bottom: MediaQuery.of(context).viewInsets.bottom + 36,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Enter Shop Code',
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            space4H,
            const CustomText(
              'Type the code shown on the shop QR card.',
              color: AppColors.kBrownTextColor,
            ),
            space16H,
            CustomTextField(
              textEditingController: _codeController,
              hintText: 'HH-SHOP-XXXXXX',
              textAlign: TextAlign.center,
            ),
            space20H,
            CustomButton(
              text: 'Join Shop',
              backgroundColor: AppColors.kSetupButtonColor,
              icon: Icons.store_outlined,
              onPressed: () {
                final code = _codeController.text.trim();
                Navigator.of(context).pop();
                widget.onSubmit(code);
              },
            ),
            space12H,
            CustomButton(
              text: 'Scan Instead',
              isOutlined: true,
              icon: Icons.qr_code_scanner,
              borderColor: Colors.grey.shade300,
              textColor: AppColors.kTextColor,
              onPressed: () {
                Navigator.of(context).pop();
                widget.onCancel();
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Decorative scanner viewfinder with animated corner brackets.
class _ScanOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const frameSize = 240.0;
    const cornerLen = 28.0;
    const cornerWidth = 4.0;
    const color = AppColors.kAccentColor;

    return Center(
      child: SizedBox(
        width: frameSize,
        height: frameSize,
        child: Stack(
          children: [
            // Dim background handled by camera overlay — just corners here
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            // Top-left
            Positioned(
              top: 0,
              left: 0,
              child: _Corner(
                top: true,
                left: true,
                len: cornerLen,
                width: cornerWidth,
                color: color,
              ),
            ),
            // Top-right
            Positioned(
              top: 0,
              right: 0,
              child: _Corner(
                top: true,
                left: false,
                len: cornerLen,
                width: cornerWidth,
                color: color,
              ),
            ),
            // Bottom-left
            Positioned(
              bottom: 0,
              left: 0,
              child: _Corner(
                top: false,
                left: true,
                len: cornerLen,
                width: cornerWidth,
                color: color,
              ),
            ),
            // Bottom-right
            Positioned(
              bottom: 0,
              right: 0,
              child: _Corner(
                top: false,
                left: false,
                len: cornerLen,
                width: cornerWidth,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final bool top;
  final bool left;
  final double len;
  final double width;
  final Color color;

  const _Corner({
    required this.top,
    required this.left,
    required this.len,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: len,
      height: len,
      child: CustomPaint(
        painter: _CornerPainter(
          top: top,
          left: left,
          width: width,
          color: color,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final bool top;
  final bool left;
  final double width;
  final Color color;

  _CornerPainter({
    required this.top,
    required this.left,
    required this.width,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = width
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final x = left ? 0.0 : size.width;
    final y = top ? 0.0 : size.height;
    final dx = left ? size.width : -size.width;
    final dy = top ? size.height : -size.height;

    canvas.drawLine(Offset(x, y), Offset(x + dx, y), paint);
    canvas.drawLine(Offset(x, y), Offset(x, y + dy), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

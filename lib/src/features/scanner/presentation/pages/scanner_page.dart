import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../src_export.dart';

class ScannerPage extends ConsumerStatefulWidget {
  const ScannerPage({super.key});

  @override
  ConsumerState<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends ConsumerState<ScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _handleBarcodeDetection(String code) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);
    _scannerController.stop(); // Pause scanning while processing API request

    try {
      final api = ref.read(apiServiceProvider);
      final response = await api.post(
        '/redemption/verify-qr-code',
        data: {'qrCode': code},
      );

      if (!mounted) return;

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
        _resumeScanning();
      }
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString().replaceAll('Exception: ', '');
      CustomSnackbar.show(context, msg, isError: true);
      _resumeScanning();
    }
  }

  void _resumeScanning() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isProcessing = false);
        _scannerController.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const CustomText(
          "Scan Customer Code",
          variant: TextVariant.titleLarge,
          color: Colors.white,
        ),
        actions: [
          // Toggle Torch Button
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _scannerController,
              builder: (context, state, child) {
                switch (state.torchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                  case TorchState.auto:
                    // TODO: Handle this case.
                    throw UnimplementedError();
                  case TorchState.unavailable:
                    // TODO: Handle this case.
                    throw UnimplementedError();
                }
              },
            ),
            onPressed: () => _scannerController.toggleTorch(),
          ),
          // Switch Camera Button
          IconButton(
            icon: const Icon(Icons.cameraswitch_outlined),
            onPressed: () => _scannerController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Real Camera Viewfinder
          MobileScanner(
            controller: _scannerController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _handleBarcodeDetection(barcode.rawValue!);
                  break;
                }
              }
            },
          ),

          // Custom Overlay Frame
          const ScannerViewfinderFrame(),

          // Loading Indicator when verifying
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),

          // Manual Entry Button
          Positioned(
            left: 12,
            right: 12,
            bottom: 24,
            child: CustomButton(
              text: "Enter Code Manually",
              isOutlined: true,
              borderColor: Colors.white70,
              textColor: Colors.white,
              icon: Icons.keyboard_outlined,
              iconColor: Colors.white,
              onPressed: () {
                _scannerController.stop();
                context.push(AppRoutes.manualCodeEntry).then((_) {
                  _scannerController.start();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
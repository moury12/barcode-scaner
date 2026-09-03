import '../../../../src_export.dart';

class ScannerViewfinderFrame extends StatelessWidget {
  const ScannerViewfinderFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, size: 60, color: Colors.white70),
            space12H,
            CustomText(
              "Align code within the frame",
              color: Colors.white,
              variant: TextVariant.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

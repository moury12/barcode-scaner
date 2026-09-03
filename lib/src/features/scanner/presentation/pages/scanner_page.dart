import '../../../../src_export.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

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
      ),
      body: Stack(
        children: [
          const ScannerViewfinderFrame(),
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
              onPressed: () => context.push(AppRoutes.manualCodeEntry),
            ),
          ),
        ],
      ),
    );
  }
}

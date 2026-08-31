import '../../../../src_export.dart';

class ScanShopQrPage extends StatelessWidget {
  const ScanShopQrPage({super.key});

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
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            children: [
              space24H,
              const CustomText(
                "Ask your shop to show you their registration QR code.",
                textAlign: TextAlign.center,
                color: Colors.white70,
                variant: TextVariant.bodyMedium,
              ),
              const Spacer(),
              // Viewfinder square with orange corner brackets
              Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      // Top Left corner
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.kAccentColor, width: 4),
                              left: BorderSide(color: AppColors.kAccentColor, width: 4),
                            ),
                          ),
                        ),
                      ),
                      // Top Right corner
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.kAccentColor, width: 4),
                              right: BorderSide(color: AppColors.kAccentColor, width: 4),
                            ),
                          ),
                        ),
                      ),
                      // Bottom Left corner
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.kAccentColor, width: 4),
                              left: BorderSide(color: AppColors.kAccentColor, width: 4),
                            ),
                          ),
                        ),
                      ),
                      // Bottom Right corner
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.kAccentColor, width: 4),
                              right: BorderSide(color: AppColors.kAccentColor, width: 4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Enter Code Manually",
                isOutlined: true,
                textColor: Colors.white,
                borderColor: Colors.white70,
                onPressed: () {
                  context.push(AppRoutes.shopDetails);
                },
              ),
              space12H,
            ],
          ),
        ),
      ),
    );
  }
}

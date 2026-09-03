import '../../../../src_export.dart';

class ManualCodeEntryPage extends StatelessWidget {
  const ManualCodeEntryPage({super.key});

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
      body: Padding(
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
            const CustomTextField(
              hintText: "000000",
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
            space24H,
            CustomButton(
              text: "Verify Code",
              backgroundColor: const Color(0xFF25160E),
              onPressed: () => context.push(AppRoutes.verifyRedemption),
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class ScanHeroCard extends ConsumerWidget {
  const ScanHeroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding24(context),
      decoration: BoxDecoration(
        color: const Color(0xFF25160E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Scan Customer Code",
            color: Colors.white,
            variant: TextVariant.headlineMedium,
            fontWeight: FontWeight.bold,
          ),
          space8H,
          const CustomText(
            "Scan a customer's daily code to redeem today's drink seamlessly.",
            color: Colors.white70,
            variant: TextVariant.bodyMedium,
          ),
          space16H,
          CustomButton(
            text: "Start Scanning",
            backgroundColor: AppColors.kYellowColor,
            textColor: Colors.black,
            icon: Icons.qr_code_scanner,
            iconColor: Colors.black,
            onPressed: () {
              ref.read(navigationProvider.notifier).state = 1;
            },
          ),
        ],
      ),
    );
  }
}

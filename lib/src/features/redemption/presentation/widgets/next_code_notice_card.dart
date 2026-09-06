import '../../../../src_export.dart';

class NextCodeNoticeCard extends StatelessWidget {
  const NextCodeNoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding24(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time, color: AppColors.kBrownTextColor, size: 20),
          space12W,
          Expanded(
            child: CustomText(
              "Your next code will be available tomorrow.",
              color: AppColors.kBrownTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

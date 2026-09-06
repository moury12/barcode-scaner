import '../../../../src_export.dart';

class AlreadyRedeemedPage extends StatelessWidget {
  const AlreadyRedeemedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          "My Daily Code",
          variant: TextVariant.titleLarge,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding24(context),
        child: Column(
          children: [
            space24H,
            const StatusIconHeader(isRedeemed: false),
            space24H,
            const CustomText(
              "Today's drink has been\nredeemed",
              variant: TextVariant.headlineLarge,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            space12H,
            const CustomText(
              "You've already used your daily drink\nbenefit.",
              textAlign: TextAlign.center,
              color: AppColors.kBrownTextColor,
            ),
            const Spacer(),
            const NextCodeNoticeCard(),
            space24H,
            CustomButton(
              text: "Back to Home",
              backgroundColor: const Color(0xFF536148),
              onPressed: () => context.go(AppRoutes.mainLayout),
            ),
          ],
        ),
      ),
    );
  }
}

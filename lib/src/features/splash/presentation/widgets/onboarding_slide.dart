import '../../../../src_export.dart';

class OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full screen image
        Positioned.fill(
          child: Align(
            alignment: AlignmentGeometry.topCenter,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        // Bottom White Card
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: Column(
              children: [
                CustomText(
                  title,
                  variant: TextVariant.displayLarge,
                  textAlign: TextAlign.center,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                space12H,
                CustomText(
                  description,
                  variant: TextVariant.bodyMedium,
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

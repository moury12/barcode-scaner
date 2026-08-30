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
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        // Bottom White Card
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
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
                  variant: TextVariant.headlineLarge,
                  textAlign: TextAlign.center,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 16),
                CustomText(
                  description,
                  variant: TextVariant.bodyMedium,
                  textAlign: TextAlign.center,
                  color: AppColors.kGreyTextColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

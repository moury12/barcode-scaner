import 'package:flutter/material.dart';
import '../../../../src_export.dart';

class OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final Widget? bottomContent;

  const OnboardingSlide({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.bottomContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Image/Illustration
        Expanded(
          flex: 6,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // Bottom White Card
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title,
                variant: TextVariant.headlineMedium,
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
                fontWeight: FontWeight.normal,
              ),
              if (bottomContent != null) ...[
                const SizedBox(height: 24),
                bottomContent!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

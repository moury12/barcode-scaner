import '../../../../src_export.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  const HomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Good morning, $name",
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            const CustomText(
              "Ready for your daily brew?",
              color: AppColors.kBrownTextColor,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Icon(
            Icons.notifications_none,
            color: AppColors.kTextColor,
          ),
        ),
      ],
    );
  }
}

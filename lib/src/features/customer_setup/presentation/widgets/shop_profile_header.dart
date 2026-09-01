import '../../../../src_export.dart';

class ShopProfileHeader extends StatelessWidget {
  final String shopName;
  final String statusText;
  final String location;
  final String description;

  const ShopProfileHeader({
    super.key,
    this.shopName = "Heritage Cafe",
    this.statusText = "PARTICIPATING",
    this.location = "Marylebone, London • 0.4 miles away",
    this.description =
        "Specialty coffee shop bringing hand-crafted espresso, single-origin roasts, and organic pastries to your daily routine. Relax in our warm ambiance.",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomNetworkImage(imageUrl: "", height: 50, width: 50, radius: 10),
        space12W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                shopName,
                variant: TextVariant.headlineLarge,
                fontWeight: FontWeight.bold,
              ),
              space4H,
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.kBrownTextColor,
                  ),
                  space4W,
                  CustomText(
                    location,
                    color: AppColors.kBrownTextColor,
                    variant: TextVariant.bodySmall,
                  ),
                ],
              ),
              // space12H,
              // CustomText(
              //   description,
              //   color: AppColors.kBrownTextColor,
              //   maxLines: 3,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

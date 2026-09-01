import '../../../../src_export.dart';

class ShopDetailsBanner extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final double height;

  const ShopDetailsBanner({
    super.key,
    this.imagePath,
    this.imageUrl,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? CustomNetworkImage(
              imageUrl: imageUrl!,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.asset(
              imagePath ?? AppStaticStrings.onboardingImg1,
              fit: BoxFit.cover,
            ),
    );
  }
}

import '../../../../src_export.dart';

class CustomerVerificationCard extends StatelessWidget {
  final String customerName;
  final String memberStatus;
  final String plan;
  final String resetTime;
  final String? customerImg;
  final String? customerEmail;
  final String? customerPhone;
  final bool isRedeemed;

  const CustomerVerificationCard({
    super.key,
    required this.customerName,
    required this.memberStatus,
    required this.plan,
    required this.resetTime,
    this.customerImg,
    this.customerEmail,
    this.customerPhone,
    this.isRedeemed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Customer avatar
              (customerImg != null && customerImg!.isNotEmpty)
                  ? ClipOval(
                      child: CustomNetworkImage(
                        imageUrl: customerImg!,
                        height: 44,
                        width: 44,
                        boxShape: BoxShape.circle,
                      ),
                    )
                  : const CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xFFE8F0E8),
                      child: Icon(Icons.person, color: AppColors.kSetupButtonColor),
                    ),
              space12W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      customerName,
                      variant: TextVariant.titleMedium,
                      fontWeight: FontWeight.bold,
                    ),
                    space2H,
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0E8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            isRedeemed ? 'Redeemed' : memberStatus,
                            fontSize: 10,
                            color: AppColors.kSetupButtonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Redeemed status banner
          if (isRedeemed) ...[
            space12H,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0E8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.kSetupButtonColor.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 18, color: AppColors.kSetupButtonColor),
                  space8W,
                  const Expanded(
                    child: CustomText(
                      "This code has been redeemed.",
                      variant: TextVariant.bodySmall,
                      color: AppColors.kSetupButtonColor,
                    ),
                  ),
                ],
              ),
            ),
          ],

          space24H,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F0E8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRedeemed ? Icons.check_circle : Icons.coffee,
              size: 36,
              color: AppColors.kSetupButtonColor,
            ),
          ),
          space16H,
          CustomText(
            isRedeemed ? "DRINK\nREDEEMED" : "TODAY'S DRINK\nAVAILABLE",
            textAlign: TextAlign.center,
            variant: TextVariant.headlineMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.kSetupButtonColor,
          ),
          space8H,
          CustomText(
            isRedeemed
                ? "This drink has been successfully redeemed."
                : "This customer has not redeemed today's drink. They are eligible for any standard menu beverage.",
            textAlign: TextAlign.center,
            color: AppColors.kBrownTextColor,
            variant: TextVariant.bodySmall,
          ),

          // Customer contact info
          if (customerEmail != null || customerPhone != null) ...[
            space16H,
            const Divider(height: 1),
            space12H,
            if (customerEmail != null && customerEmail!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined,
                        size: 16, color: AppColors.kBrownTextColor),
                    space8W,
                    Flexible(
                      child: CustomText(
                        customerEmail!,
                        variant: TextVariant.bodySmall,
                        color: AppColors.kBrownTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            if (customerPhone != null && customerPhone!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.phone_outlined,
                      size: 16, color: AppColors.kBrownTextColor),
                  space8W,
                  CustomText(
                    customerPhone!,
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                  ),
                ],
              ),
          ],

          space24H,
          const Divider(height: 1),
          space16H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText("PLAN",
                      variant: TextVariant.labelSmall,
                      color: AppColors.kBrownTextColor),
                  space4H,
                  CustomText(plan,
                      variant: TextVariant.bodyMedium,
                      fontWeight: FontWeight.bold),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CustomText("RESET TIME",
                      variant: TextVariant.labelSmall,
                      color: AppColors.kBrownTextColor),
                  space4H,
                  CustomText(resetTime,
                      variant: TextVariant.bodyMedium,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

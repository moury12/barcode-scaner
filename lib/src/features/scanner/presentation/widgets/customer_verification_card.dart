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
                            color: isRedeemed
                                ? const Color(0xFFFFE8E8)
                                : const Color(0xFFE8F0E8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            isRedeemed ? 'Already Redeemed' : memberStatus,
                            fontSize: 10,
                            color: isRedeemed
                                ? Colors.red.shade700
                                : AppColors.kSetupButtonColor,
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

          // Redeemed warning banner
          if (isRedeemed) ...[
            space12H,
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      size: 18, color: Colors.red.shade700),
                  space8W,
                  Expanded(
                    child: CustomText(
                      "This customer has already redeemed today's drink.",
                      variant: TextVariant.bodySmall,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],

          space24H,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isRedeemed
                  ? const Color(0xFFFFF0F0)
                  : const Color(0xFFE8F0E8),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRedeemed ? Icons.block : Icons.coffee,
              size: 36,
              color: isRedeemed
                  ? Colors.red.shade400
                  : AppColors.kSetupButtonColor,
            ),
          ),
          space16H,
          CustomText(
            isRedeemed ? "TODAY'S DRINK\nALREADY USED" : "TODAY'S DRINK\nAVAILABLE",
            textAlign: TextAlign.center,
            variant: TextVariant.headlineMedium,
            fontWeight: FontWeight.bold,
            color: isRedeemed ? Colors.red.shade500 : AppColors.kSetupButtonColor,
          ),
          space8H,
          CustomText(
            isRedeemed
                ? "This customer has already redeemed today's drink. They are not eligible for another."
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

import '../../../../src_export.dart';

class CustomerVerificationCard extends StatelessWidget {
  final String customerName;
  final String memberStatus;
  final String plan;
  final String resetTime;

  const CustomerVerificationCard({
    super.key,
    required this.customerName,
    required this.memberStatus,
    required this.plan,
    required this.resetTime,
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
              const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=47'),
              ),
              space12W,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    customerName,
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  space2H,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0E8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomText(
                      memberStatus,
                      fontSize: 10,
                      color: AppColors.kSetupButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          space24H,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F0E8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.coffee, size: 36, color: AppColors.kSetupButtonColor),
          ),
          space16H,
          const CustomText(
            "TODAY'S DRINK\nAVAILABLE",
            textAlign: TextAlign.center,
            variant: TextVariant.headlineMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.kSetupButtonColor,
          ),
          space8H,
          const CustomText(
            "This customer has not redeemed today's drink. They are eligible for any standard menu beverage.",
            textAlign: TextAlign.center,
            color: AppColors.kBrownTextColor,
            variant: TextVariant.bodySmall,
          ),
          space24H,
          const Divider(height: 1),
          space16H,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText("PLAN", variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
                  space4H,
                  CustomText(plan, variant: TextVariant.bodyMedium, fontWeight: FontWeight.bold),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CustomText("RESET TIME", variant: TextVariant.labelSmall, color: AppColors.kBrownTextColor),
                  space4H,
                  CustomText(resetTime, variant: TextVariant.bodyMedium, fontWeight: FontWeight.bold),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

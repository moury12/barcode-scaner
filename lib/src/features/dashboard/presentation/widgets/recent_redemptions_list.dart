import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../../../customer_management/presentation/controllers/redemption_history_controller.dart';

class RecentRedemptionsList extends ConsumerWidget {
  const RecentRedemptionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerRedemptionsProvider);
    final items = state.redemptions.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              "Recent Redemptions",
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            ButtonTapWidget(
              onTap: () => context.push(AppRoutes.redemptionHistory),
              child: const CustomText(
                "View All",
                variant: TextVariant.labelSmall,
                color: AppColors.kAccentColor,
              ),
            ),
          ],
        ),
        space12H,
        if (state.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (items.isEmpty)
          const CustomText(
            "No recent redemptions.",
            color: AppColors.kBrownTextColor,
            variant: TextVariant.bodySmall,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => space8H,
            itemBuilder: (context, index) {
              final item = items[index];
              final name = item.customerName.isNotEmpty ? item.customerName : "Customer";
              final initials = name.isNotEmpty
                  ? name.split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
                  : "CU";
              final dateStr = item.createdAt != null
                  ? "${item.createdAt!.hour}:${item.createdAt!.minute.toString().padLeft(2, '0')}"
                  : "Today";

              return RecentRedemptionTile(
                nameInitials: initials,
                customerName: name,
                drinkName: "Code: ${item.qrCode}",
                timeAgo: dateStr,
              );
            },
          ),
      ],
    );
  }
}

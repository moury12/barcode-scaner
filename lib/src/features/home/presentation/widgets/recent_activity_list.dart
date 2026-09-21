import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../../../customer_management/presentation/controllers/redemption_history_controller.dart';

class RecentActivityList extends ConsumerWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(customerRedemptionsProvider);
    final items = state.redemptions.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: CustomText(
                "RECENT ACTIVITY",
                variant: TextVariant.labelSmall,
                fontWeight: FontWeight.bold,
                color: AppColors.kBrownTextColor,
              ),
            ),
            ButtonTapWidget(
              onTap: () {
                ref.read(navigationProvider.notifier).state = 2;
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: CustomText(
                  "View All",
                  fontSize: 10,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        space8H,
        Container(
          padding: AppPadding.getPadding12(context),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: state.isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: CircularProgressIndicator(),
                  ),
                )
              : items.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: CustomText(
                          "No recent activity.",
                          color: AppColors.kBrownTextColor,
                          variant: TextVariant.bodySmall,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final shopName =
                            item.shopName.isNotEmpty ? item.shopName : "Shop";
                        final dateStr = item.createdAt != null
                            ? "${item.createdAt!.day}/${item.createdAt!.month} ${item.createdAt!.hour}:${item.createdAt!.minute.toString().padLeft(2, '0')}"
                            : "";

                        return _ActivityTile(
                          shopName: shopName,
                          timestamp: dateStr,
                          isUsed: item.isUsed,
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String shopName;
  final String timestamp;
  final bool isUsed;

  const _ActivityTile({
    required this.shopName,
    required this.timestamp,
    required this.isUsed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFFF1F1F1),
          child: Icon(Icons.coffee, size: 18, color: AppColors.kTextColor),
        ),
        space12W,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(shopName, fontWeight: FontWeight.bold),
              if (timestamp.isNotEmpty)
                CustomText(
                  timestamp,
                  variant: TextVariant.bodySmall,
                  color: AppColors.kBrownTextColor,
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isUsed ? const Color(0xFFE8F0E8) : const Color(0xFFFFF8E7),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(
            isUsed ? "Redeemed" : "Pending",
            fontSize: 10,
            color: isUsed ? const Color(0xFF536148) : const Color(0xFFD97706),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../controllers/redemption_history_controller.dart';
import '../../data/models/redemption_history_models.dart';

class RedemptionHistoryPage extends ConsumerStatefulWidget {
  const RedemptionHistoryPage({super.key});

  @override
  ConsumerState<RedemptionHistoryPage> createState() =>
      _RedemptionHistoryPageState();
}

class _RedemptionHistoryPageState extends ConsumerState<RedemptionHistoryPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(ownerRedemptionsProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleVerify(String qrCode) async {
    final success = await ref
        .read(ownerRedemptionsProvider.notifier)
        .verifyQrCode(qrCode);

    if (!mounted) return;
    if (success) {
      CustomSnackbar.show(
        context,
        'QR Code verified successfully!',
        isError: false,
      );
    } else {
      CustomSnackbar.show(context, 'Failed to verify QR Code', isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ownerRedemptionsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText(
          "Redemption History",
          variant: TextVariant.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(ownerRedemptionsProvider.notifier).fetch(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  space12H,
                  CustomText(
                    state.errorMessage!,
                    color: AppColors.kBrownTextColor,
                  ),
                  space16H,
                  CustomButton(
                    text: 'Retry',
                    onPressed: () =>
                        ref.read(ownerRedemptionsProvider.notifier).fetch(),
                  ),
                ],
              ),
            )
          : state.redemptions.isEmpty
          ? const Center(
              child: CustomText(
                "No redemptions found.",
                color: AppColors.kBrownTextColor,
              ),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(ownerRedemptionsProvider.notifier).fetch(),
              child: ListView.separated(
                controller: _scrollController,
                padding: AppPadding.getPadding12(context),
                itemCount:
                    state.redemptions.length + (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (context, index) => space12H,
                itemBuilder: (context, index) {
                  if (index == state.redemptions.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final item = state.redemptions[index];
                  return _redemptionTile(item);
                },
              ),
            ),
    );
  }

  Widget _redemptionTile(OwnerRedemptionModel item) {
    final name = item.customerName.isNotEmpty ? item.customerName : "Customer";
    final dateStr = item.createdAt != null
        ? "${item.createdAt!.day}/${item.createdAt!.month}/${item.createdAt!.year} ${item.createdAt!.hour}:${item.createdAt!.minute.toString().padLeft(2, '0')}"
        : "";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: item.customerImg.isNotEmpty
                ? CustomNetworkImage(
                    imageUrl: item.customerImg,
                    height: 44,
                    width: 44,
                    radius: 22,
                  )
                : const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFFF1F1F1),
                    child: Icon(Icons.person, color: AppColors.kTextColor),
                  ),
          ),
          space12W,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(name, fontWeight: FontWeight.bold),
              space2H,
              CustomText(
                "Code: ${item.qrCode}",
                variant: TextVariant.bodySmall,
                color: AppColors.kBrownTextColor,
              ),
              if (dateStr.isNotEmpty)
                CustomText(dateStr, fontSize: 10, color: Colors.grey),
            ],
          ),
          space8W,
          if (item.isUsed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const CustomText(
                "REDEEMED",
                fontSize: 10,
                color: Color(0xFF536148),
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Expanded(
              child: CustomButton(
                text: "Verify",
                backgroundColor: AppColors.kPrimaryColor,
                onPressed: () => _handleVerify(item.qrCode),
              ),
            ),
        ],
      ),
    );
  }
}

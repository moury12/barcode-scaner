import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';
import '../../../customer_management/presentation/controllers/redemption_history_controller.dart';
import '../../../customer_management/data/models/redemption_history_models.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(customerRedemptionsProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(customerRedemptionsProvider.notifier).search(value);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerRedemptionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText("History", variant: TextVariant.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(customerRedemptionsProvider.notifier).fetch(),
          ),
        ],
      ),
      body: Padding(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          children: [
            space8H,
            CustomTextField(
              textEditingController: _searchController,
              hintText: "Search redemptions...",
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(customerRedemptionsProvider.notifier).search('');
                        setState(() {});
                      },
                    )
                  : null,
              onChanged: (val) {
                setState(() {});
                _onSearchChanged(val);
              },
            ),
            space12H,
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline,
                                  size: 48, color: Colors.red),
                              space12H,
                              CustomText(
                                state.errorMessage!,
                                color: AppColors.kBrownTextColor,
                              ),
                              space16H,
                              CustomButton(
                                text: 'Retry',
                                onPressed: () => ref
                                    .read(customerRedemptionsProvider.notifier)
                                    .fetch(),
                              ),
                            ],
                          ),
                        )
                      : state.redemptions.isEmpty
                          ? const Center(
                              child: CustomText(
                                "No redemption history found.",
                                color: AppColors.kBrownTextColor,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () => ref
                                  .read(customerRedemptionsProvider.notifier)
                                  .fetch(),
                              child: ListView.separated(
                                controller: _scrollController,
                                padding: const EdgeInsets.only(bottom: 16),
                                itemCount: state.redemptions.length +
                                    (state.isLoadingMore ? 1 : 0),
                                separatorBuilder: (_, __) => space12H,
                                itemBuilder: (context, index) {
                                  if (index == state.redemptions.length) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                                  }
                                  final item = state.redemptions[index];
                                  return _historyTile(item);
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _historyTile(CustomerRedemptionModel item) {
    final shopName = item.shopName.isNotEmpty ? item.shopName : "Shop";
    final dateStr = item.createdAt != null
        ? "${item.createdAt!.day}/${item.createdAt!.month}/${item.createdAt!.year} ${item.createdAt!.hour}:${item.createdAt!.minute.toString().padLeft(2, '0')}"
        : "";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item.image.isNotEmpty
                ? CustomNetworkImage(
                    imageUrl: item.image,
                    height: 44,
                    width: 44,
                    radius: 8,
                  )
                : const CircleAvatar(
                    backgroundColor: Color(0xFFF1F1F1),
                    child: Icon(Icons.coffee, size: 20, color: AppColors.kTextColor),
                  ),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(shopName, fontWeight: FontWeight.bold),
                space2H,
                CustomText(
                  "Code: ${item.qrCode}",
                  variant: TextVariant.bodySmall,
                  color: AppColors.kBrownTextColor,
                ),
                if (dateStr.isNotEmpty)
                  CustomText(
                    dateStr,
                    fontSize: 10,
                    color: Colors.grey,
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: item.isUsed
                  ? const Color(0xFFE8F0E8)
                  : const Color(0xFFFFF8E7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomText(
              item.isUsed ? "Redeemed" : "Pending",
              fontSize: 10,
              color: item.isUsed
                  ? const Color(0xFF536148)
                  : const Color(0xFFD97706),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

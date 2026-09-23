import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class FindShopPage extends ConsumerStatefulWidget {
  const FindShopPage({super.key});

  @override
  ConsumerState<FindShopPage> createState() => _FindShopPageState();
}

class _FindShopPageState extends ConsumerState<FindShopPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(
      () => ref.read(myMembershipsProvider.notifier).fetchMyMemberships(),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(shopListProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(shopListProvider.notifier).search(value);
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
    final shopAsync = ref.watch(shopListProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () {
              ref.read(shopListProvider.notifier).refresh();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space16H,
                const Center(
                  child: CustomText(
                    AppStaticStrings.findYourShop,
                    variant: TextVariant.displaySmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                space8H,
                const CustomText(
                  AppStaticStrings.findYourShopDesc,
                  textAlign: TextAlign.center,
                  color: AppColors.kBrownTextColor,
                ),
                space16H,
                CustomTextField(
                  textEditingController: _searchController,
                  hintText: "Search by name or location",
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(shopListProvider.notifier).search('');
                            setState(() {});
                          },
                        )
                      : null,
                  onChanged: (val) {
                    setState(() {});
                    _onSearchChanged(val);
                  },
                ),
                space16H,
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () =>
                        ref.read(shopListProvider.notifier).refresh(),
                    child: shopAsync.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, _) => ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 48,
                                  color: Colors.red,
                                ),
                                space12H,
                                CustomText(
                                  err.toString().replaceAll('Exception: ', ''),
                                  textAlign: TextAlign.center,
                                  color: AppColors.kBrownTextColor,
                                ),
                                space16H,
                                CustomButton(
                                  text: 'Retry',
                                  backgroundColor: AppColors.kPrimaryColor,
                                  onPressed: () => ref
                                      .read(shopListProvider.notifier)
                                      .refresh(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      data: (state) {
                        if (state.shops.isEmpty) {
                          return ListView(
                            children: [
                              SizedBox(
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                child: const Center(
                                  child: CustomText(
                                    'No shops found.',
                                    color: AppColors.kBrownTextColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return ListView.separated(
                          controller: _scrollController,
                          itemCount:
                              state.shops.length +
                              (state.isLoadingMore ? 1 : 0),
                          separatorBuilder: (context, index) => space12H,
                          itemBuilder: (context, index) {
                            if (index == state.shops.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return _shopTile(context, state.shops[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
                // if (ref.watch(myMembershipsProvider).memberships.isNotEmpty) ...[
                space12H,
                Center(
                  child: ButtonTapWidget(
                    onTap: () {
                      context.go(AppRoutes.mainLayout);
                    },
                    child: const CustomText(
                      "Go to home page",
                      color: AppColors.kBrownTextColor,
                    ),
                  ),
                ),

                space12H,
                CustomButton(
                  text: AppStaticStrings.scanShopQr,
                  backgroundColor: AppColors.kSetupButtonColor,
                  icon: Icons.qr_code_scanner,
                  onPressed: () => context.push(AppRoutes.scanShopQr),
                ),
              ],
            ),
          ),
        ),
      
    );
  }

  Widget _shopTile(BuildContext context, CustomerShopModel shop) {
    return ButtonTapWidget(
      onTap: () =>
          context.push(AppRoutes.shopDetails, extra: {'shopId': shop.id}),
      radius: 12,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: shop.image.isNotEmpty
                  ? CustomNetworkImage(
                      imageUrl: shop.image,
                      height: 48,
                      width: 48,
                      radius: 8,
                    )
                  : Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
            ),
            space12W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(shop.name, fontWeight: FontWeight.bold),
                  space2H,
                  CustomText(
                    shop.address,
                    variant: TextVariant.bodySmall,
                    color: AppColors.kBrownTextColor,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

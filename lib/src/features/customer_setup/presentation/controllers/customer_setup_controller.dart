import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/customer_shop_remote_datasource.dart';
import '../../data/models/single_customer_shop_model.dart';

// ─────────────────────────────────────────────
// Shop List (Paginated)
// ─────────────────────────────────────────────

class ShopListState {
  final List<CustomerShopModel> shops;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const ShopListState({
    this.shops = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.errorMessage,
  });

  ShopListState copyWith({
    List<CustomerShopModel>? shops,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return ShopListState(
      shops: shops ?? this.shops,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

class ShopListNotifier extends AsyncNotifier<ShopListState> {
  static const int _pageSize = 10;
  String _searchTerm = '';

  @override
  Future<ShopListState> build() async {
    return _fetchPage(1, isInitial: true);
  }

  Future<ShopListState> _fetchPage(int page, {String? searchTerm, bool isInitial = false}) async {
    final term = searchTerm ?? _searchTerm;
    final ds = ref.read(customerShopRemoteDataSourceProvider);
    final response = await ds.getCustomerShops(
      page: page,
      limit: _pageSize,
      searchTerm: term.isNotEmpty ? term : null,
    );
    final hasMore = page < response.meta.totalPages;
    final existing = isInitial ? <CustomerShopModel>[] : (state.value?.shops ?? []);
    return ShopListState(
      shops: [...existing, ...response.shops],
      isLoading: false,
      isLoadingMore: false,
      hasMore: hasMore,
      currentPage: page,
    );
  }

  Future<void> search(String query) async {
    _searchTerm = query.trim();
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(1, searchTerm: _searchTerm, isInitial: true));
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await _fetchPage(current.currentPage + 1, searchTerm: _searchTerm);
      state = AsyncData(next);
    } catch (e) {
      state = AsyncData(current.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      ));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage(1, searchTerm: _searchTerm, isInitial: true));
  }
}

final shopListProvider =
    AsyncNotifierProvider<ShopListNotifier, ShopListState>(ShopListNotifier.new);

// ─────────────────────────────────────────────
// Single Shop Detail
// ─────────────────────────────────────────────

class ShopDetailState {
  final SingleCustomerShopModel? shop;
  final bool isLoading;
  final bool isJoining;
  final String? errorMessage;
  final String? successMessage;

  const ShopDetailState({
    this.shop,
    this.isLoading = false,
    this.isJoining = false,
    this.errorMessage,
    this.successMessage,
  });

  ShopDetailState copyWith({
    SingleCustomerShopModel? shop,
    bool? isLoading,
    bool? isJoining,
    String? errorMessage,
    String? successMessage,
  }) {
    return ShopDetailState(
      shop: shop ?? this.shop,
      isLoading: isLoading ?? this.isLoading,
      isJoining: isJoining ?? this.isJoining,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class ShopDetailNotifier extends Notifier<ShopDetailState> {
  @override
  ShopDetailState build() {
    return const ShopDetailState();
  }

  Future<void> load(String shopId) async {
    // Delay slightly to allow build to finish if called in initState without post frame
    Future.microtask(() {
      state = const ShopDetailState(isLoading: true);
    });
    try {
      final ds = ref.read(customerShopRemoteDataSourceProvider);
      final shop = await ds.getSingleCustomerShop(shopId);
      state = ShopDetailState(shop: shop);
    } catch (e) {
      state = ShopDetailState(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> joinShop(String shopId) async {
    if (state.isJoining) return;
    state = state.copyWith(isJoining: true);
    try {
      final ds = ref.read(customerShopRemoteDataSourceProvider);
      await ds.joinShop(shopId);
      // Update local isJoin flag
      final updated = state.shop;
      if (updated != null) {
        state = ShopDetailState(
          shop: SingleCustomerShopModel(
            id: updated.id,
            name: updated.name,
            image: updated.image,
            contactNumber: updated.contactNumber,
            description: updated.description,
            address: updated.address,
            dailyBenefitDescription: updated.dailyBenefitDescription,
            qrCode: updated.qrCode,
            totalActiveCustomers: updated.totalActiveCustomers,
            openingHours: updated.openingHours,
            isJoin: true,
            membershipStatus: 'pending',
            createdAt: updated.createdAt,
            updatedAt: updated.updatedAt,
          ),
          successMessage: 'Join request sent successfully.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isJoining: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

final shopDetailProvider = NotifierProvider<ShopDetailNotifier, ShopDetailState>(ShopDetailNotifier.new);

// ─────────────────────────────────────────────
// Customer Setup (Legacy)
// ─────────────────────────────────────────────

enum JoinStatus { initial, pending, active }

class CustomerSetupNotifier extends Notifier<JoinStatus> {
  @override
  JoinStatus build() => JoinStatus.initial;

  void sendRequest() => state = JoinStatus.pending;

  void approveRequest() => state = JoinStatus.active;
}

final customerSetupProvider =
    NotifierProvider<CustomerSetupNotifier, JoinStatus>(CustomerSetupNotifier.new);

import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/services/api_service.dart';
import '../../data/datasources/redemption_history_datasource.dart';
import '../../data/models/redemption_history_models.dart';

class OwnerRedemptionsState {
  final bool isLoading;
  final bool isLoadingMore;
  final List<OwnerRedemptionModel> redemptions;
  final int page;
  final bool hasMore;
  final String? errorMessage;

  const OwnerRedemptionsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.redemptions = const [],
    this.page = 1,
    this.hasMore = true,
    this.errorMessage,
  });

  OwnerRedemptionsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<OwnerRedemptionModel>? redemptions,
    int? page,
    bool? hasMore,
    String? errorMessage,
  }) {
    return OwnerRedemptionsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      redemptions: redemptions ?? this.redemptions,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage,
    );
  }
}

class OwnerRedemptionsNotifier extends StateNotifier<OwnerRedemptionsState> {
  final RedemptionHistoryRemoteDataSource _ds;
  final ApiService _api;

  OwnerRedemptionsNotifier(this._ds, this._api) : super(const OwnerRedemptionsState()) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1, hasMore: true);
    try {
      final list = await _ds.getOwnerRedemptions(page: 1, limit: 10);
      state = state.copyWith(
        isLoading: false,
        redemptions: list,
        page: 1,
        hasMore: list.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final list = await _ds.getOwnerRedemptions(page: nextPage, limit: 10);
      state = state.copyWith(
        isLoadingMore: false,
        redemptions: [...state.redemptions, ...list],
        page: nextPage,
        hasMore: list.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<bool> verifyQrCode(String qrCode) async {
    try {
      final response = await _api.post(
        '/redemption/verify-qr-code',
        data: {'qrCode': qrCode},
      );
      if (response.data != null && response.data['success'] == true) {
        await fetch();
        return true;
      }
    } catch (_) {}
    return false;
  }
}

final ownerRedemptionsProvider =
    StateNotifierProvider<OwnerRedemptionsNotifier, OwnerRedemptionsState>((ref) {
  final ds = ref.watch(redemptionHistoryRemoteDataSourceProvider);
  final api = ref.watch(apiServiceProvider);
  return OwnerRedemptionsNotifier(ds, api);
});

class CustomerRedemptionsState {
  final bool isLoading;
  final bool isLoadingMore;
  final List<CustomerRedemptionModel> redemptions;
  final int page;
  final bool hasMore;
  final String? searchTerm;
  final String? errorMessage;

  const CustomerRedemptionsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.redemptions = const [],
    this.page = 1,
    this.hasMore = true,
    this.searchTerm,
    this.errorMessage,
  });

  CustomerRedemptionsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<CustomerRedemptionModel>? redemptions,
    int? page,
    bool? hasMore,
    String? searchTerm,
    String? errorMessage,
  }) {
    return CustomerRedemptionsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      redemptions: redemptions ?? this.redemptions,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      searchTerm: searchTerm ?? this.searchTerm,
      errorMessage: errorMessage,
    );
  }
}

class CustomerRedemptionsNotifier extends StateNotifier<CustomerRedemptionsState> {
  final RedemptionHistoryRemoteDataSource _ds;

  CustomerRedemptionsNotifier(this._ds) : super(const CustomerRedemptionsState()) {
    fetch();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true, errorMessage: null, page: 1, hasMore: true);
    try {
      final list = await _ds.getCustomerRedemptions(
        page: 1,
        limit: 10,
        searchTerm: state.searchTerm,
      );
      state = state.copyWith(
        isLoading: false,
        redemptions: list,
        page: 1,
        hasMore: list.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  void search(String term) {
    state = state.copyWith(searchTerm: term);
    fetch();
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);
    try {
      final nextPage = state.page + 1;
      final list = await _ds.getCustomerRedemptions(
        page: nextPage,
        limit: 10,
        searchTerm: state.searchTerm,
      );
      state = state.copyWith(
        isLoadingMore: false,
        redemptions: [...state.redemptions, ...list],
        page: nextPage,
        hasMore: list.length >= 10,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false);
    }
  }
}

final customerRedemptionsProvider =
    StateNotifierProvider<CustomerRedemptionsNotifier, CustomerRedemptionsState>((ref) {
  final ds = ref.watch(redemptionHistoryRemoteDataSourceProvider);
  return CustomerRedemptionsNotifier(ds);
});

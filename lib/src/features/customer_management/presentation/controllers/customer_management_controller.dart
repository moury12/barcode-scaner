import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/customer_membership_remote_datasource.dart';
import '../../data/models/customer_membership_model.dart';

class CustomerListState {
  final List<CustomerMembershipModel> items;
  final String status; // 'active', 'pending', 'paused', 'rejected'
  final String searchTerm;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final bool isUpdatingStatus;
  final String? errorMessage;
  final String? successMessage;

  const CustomerListState({
    this.items = const [],
    this.status = 'active',
    this.searchTerm = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.isUpdatingStatus = false,
    this.errorMessage,
    this.successMessage,
  });

  CustomerListState copyWith({
    List<CustomerMembershipModel>? items,
    String? status,
    String? searchTerm,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    bool? isUpdatingStatus,
    String? errorMessage,
    String? successMessage,
  }) {
    return CustomerListState(
      items: items ?? this.items,
      status: status ?? this.status,
      searchTerm: searchTerm ?? this.searchTerm,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isUpdatingStatus: isUpdatingStatus ?? this.isUpdatingStatus,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class CustomerManagementController extends Notifier<CustomerListState> {
  static const int _pageSize = 10;

  @override
  CustomerListState build() {
    Future.microtask(() => fetchList(status: 'active', isInitial: true));
    return const CustomerListState(isLoading: true, status: 'active');
  }

  Future<void> setStatusTab(String status) async {
    if (state.status.toLowerCase() == status.toLowerCase() && state.items.isNotEmpty) {
      return;
    }
    state = state.copyWith(
      status: status.toLowerCase(),
      isLoading: true,
      items: [],
      currentPage: 0,
      hasMore: true,
      errorMessage: null,
    );
    await fetchList(
      status: status.toLowerCase(),
      searchTerm: state.searchTerm,
      page: 1,
      isInitial: true,
    );
  }

  Future<void> search(String query) async {
    final term = query.trim();
    state = state.copyWith(
      searchTerm: term,
      isLoading: true,
      items: [],
      currentPage: 0,
      hasMore: true,
      errorMessage: null,
    );
    await fetchList(
      status: state.status,
      searchTerm: term,
      page: 1,
      isInitial: true,
    );
  }

  Future<void> fetchList({
    required String status,
    String? searchTerm,
    int page = 1,
    bool isInitial = false,
  }) async {
    try {
      final ds = ref.read(customerMembershipRemoteDataSourceProvider);
      final response = await ds.getMembershipRequests(
        page: page,
        limit: _pageSize,
        status: status,
        searchTerm: searchTerm ?? state.searchTerm,
      );

      final hasMore = page < response.meta.totalPages;
      final existing = isInitial ? <CustomerMembershipModel>[] : state.items;

      state = state.copyWith(
        items: [...existing, ...response.data],
        isLoading: false,
        isLoadingMore: false,
        hasMore: hasMore,
        currentPage: page,
        status: status,
        searchTerm: searchTerm ?? state.searchTerm,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) return;
    state = state.copyWith(isLoadingMore: true);
    await fetchList(
      status: state.status,
      searchTerm: state.searchTerm,
      page: state.currentPage + 1,
    );
  }

  Future<void> refresh() async {
    await fetchList(
      status: state.status,
      searchTerm: state.searchTerm,
      page: 1,
      isInitial: true,
    );
  }

  Future<bool> updateStatus({
    required String membershipId,
    required String newStatus,
  }) async {
    state = state.copyWith(
      isUpdatingStatus: true,
      errorMessage: null,
      successMessage: null,
    );
    try {
      final ds = ref.read(customerMembershipRemoteDataSourceProvider);
      await ds.updateMembershipStatus(
        membershipId: membershipId,
        status: newStatus,
      );

      state = state.copyWith(
        isUpdatingStatus: false,
        successMessage: 'Membership status updated to $newStatus successfully.',
      );

      await refresh();
      return true;
    } catch (e) {
      state = state.copyWith(
        isUpdatingStatus: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }
}

final customerManagementProvider =
    NotifierProvider<CustomerManagementController, CustomerListState>(
  CustomerManagementController.new,
);

import 'package:barcode_scaner/src/features/customer_setup/data/datasources/customer_shop_remote_datasource.dart';
import 'package:barcode_scaner/src/features/customer_setup/presentation/customer_setup_presentation_export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class MyMembershipsState {
  final bool isLoading;
  final List<MyMembershipModel> memberships;
  final String? errorMessage;
  final bool hasFetched;

  const MyMembershipsState({
    this.isLoading = false,
    this.memberships = const [],
    this.errorMessage,
    this.hasFetched = false,
  });

  MyMembershipsState copyWith({
    bool? isLoading,
    List<MyMembershipModel>? memberships,
    String? errorMessage,
    bool? hasFetched,
  }) {
    return MyMembershipsState(
      isLoading: isLoading ?? this.isLoading,
      memberships: memberships ?? this.memberships,
      errorMessage: errorMessage,
      hasFetched: hasFetched ?? this.hasFetched,
    );
  }
}

class MyMembershipsNotifier extends StateNotifier<MyMembershipsState> {
  final CustomerShopRemoteDataSource _dataSource;
  final Ref _ref;

  MyMembershipsNotifier(this._dataSource, this._ref)
      : super(const MyMembershipsState());

  Future<List<MyMembershipModel>> fetchMyMemberships({bool force = false}) async {
    if (state.hasFetched && !force && !state.isLoading) {
      return state.memberships;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final memberships = await _dataSource.getMyActiveMemberships();
      state = state.copyWith(
        isLoading: false,
        memberships: memberships,
        hasFetched: true,
      );

      // Auto-select first membership if none selected or update current selection with fresh data
      final currentSelected = _ref.read(selectedMembershipProvider);
      if (memberships.isNotEmpty) {
        if (currentSelected == null ||
            !memberships.any((m) => m.id == currentSelected.id)) {
          _ref.read(selectedMembershipProvider.notifier).state =
              memberships.first;
        } else {
          final refreshedItem = memberships.firstWhere(
            (m) => m.id == currentSelected.id,
          );
          _ref.read(selectedMembershipProvider.notifier).state = refreshedItem;
        }
      } else {
        _ref.read(selectedMembershipProvider.notifier).state = null;
      }

      return memberships;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(
        isLoading: false,
        errorMessage: msg,
        hasFetched: true,
      );
      return [];
    }
  }

  void selectMembership(MyMembershipModel membership) {
    _ref.read(selectedMembershipProvider.notifier).state = membership;
  }
}

final myMembershipsProvider =
    StateNotifierProvider<MyMembershipsNotifier, MyMembershipsState>((ref) {
  final ds = ref.watch(customerShopRemoteDataSourceProvider);
  return MyMembershipsNotifier(ds, ref);
});

final selectedMembershipProvider = StateProvider<MyMembershipModel?>((ref) => null);

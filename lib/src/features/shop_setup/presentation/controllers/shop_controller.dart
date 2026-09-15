import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/shop_remote_datasource.dart';
import '../../data/models/shop_model.dart';

// ─── SHOP STATE ───
class ShopState {
  final ShopModel? shop;
  final bool isLoading;
  final String? errorMessage;

  const ShopState({
    this.shop,
    this.isLoading = false,
    this.errorMessage,
  });

  ShopState copyWith({
    ShopModel? shop,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ShopState(
      shop: shop ?? this.shop,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ShopController extends Notifier<ShopState> {
  @override
  ShopState build() => const ShopState();

  Future<bool> fetchMyShop() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final ds = ref.read(shopRemoteDataSourceProvider);
      final shop = await ds.getMyShop();
      state = ShopState(shop: shop, isLoading: false);
      return true;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = ShopState(isLoading: false, errorMessage: msg);
      return false;
    }
  }

  Future<bool> createShop({
    required String name,
    required String contactNumber,
    required String description,
    required String address,
    String? imagePath,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final ds = ref.read(shopRemoteDataSourceProvider);
      final shop = await ds.createShop(
        name: name,
        contactNumber: contactNumber,
        description: description,
        address: address,
        imagePath: imagePath,
      );
      state = ShopState(shop: shop, isLoading: false);
      return true;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = ShopState(isLoading: false, errorMessage: msg);
      return false;
    }
  }

  Future<bool> updateShop({
    String? name,
    String? contactNumber,
    String? description,
    String? address,
    String? imagePath,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final ds = ref.read(shopRemoteDataSourceProvider);
      final shop = await ds.updateShop(
        name: name,
        contactNumber: contactNumber,
        description: description,
        address: address,
        imagePath: imagePath,
      );
      state = ShopState(shop: shop, isLoading: false);
      return true;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = ShopState(isLoading: false, errorMessage: msg);
      return false;
    }
  }
}

final shopControllerProvider =
    NotifierProvider<ShopController, ShopState>(ShopController.new);

// ─── OPENING HOUR STATE ───
class OpeningHourState {
  final List<OpeningHourModel> hours;
  final bool isLoading;
  final bool isAdding;
  final String? errorMessage;
  final String? successMessage;

  const OpeningHourState({
    this.hours = const [],
    this.isLoading = false,
    this.isAdding = false,
    this.errorMessage,
    this.successMessage,
  });

  OpeningHourState copyWith({
    List<OpeningHourModel>? hours,
    bool? isLoading,
    bool? isAdding,
    String? errorMessage,
    String? successMessage,
  }) {
    return OpeningHourState(
      hours: hours ?? this.hours,
      isLoading: isLoading ?? this.isLoading,
      isAdding: isAdding ?? this.isAdding,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }
}

class OpeningHourController extends Notifier<OpeningHourState> {
  @override
  OpeningHourState build() => const OpeningHourState();

  Future<void> fetchOpeningHours() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final ds = ref.read(shopRemoteDataSourceProvider);
      final hours = await ds.getOpeningHours();
      state = state.copyWith(hours: hours, isLoading: false);
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(isLoading: false, errorMessage: msg);
    }
  }

  Future<bool> addOpeningHour({
    required String day,
    required String openTime,
    required String closeTime,
  }) async {
    state = state.copyWith(isAdding: true, errorMessage: null, successMessage: null);
    try {
      final ds = ref.read(shopRemoteDataSourceProvider);
      final hour = await ds.createOpeningHour(
        day: day,
        openTime: openTime,
        closeTime: closeTime,
      );
      state = state.copyWith(
        isAdding: false,
        hours: [...state.hours, hour],
        successMessage: 'Opening hour added successfully',
      );
      return true;
    } catch (e) {
      final msg = e.toString().replaceAll('Exception: ', '');
      state = state.copyWith(isAdding: false, errorMessage: msg);
      return false;
    }
  }
}

final openingHourControllerProvider =
    NotifierProvider<OpeningHourController, OpeningHourState>(
        OpeningHourController.new);

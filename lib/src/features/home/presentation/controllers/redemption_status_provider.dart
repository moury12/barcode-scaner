import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/services/api_service.dart';

/// Checks whether today's drink has been redeemed for the given shop name.
/// Calls GET /redemption/customer-redemptions?isRedeemed=true&searchTerm={shopName}&timeframe=today
/// Returns true when the list is non-empty (already redeemed), false otherwise.
final redemptionStatusProvider =
    FutureProvider.family<bool, String?>((ref, shopName) async {
  if (shopName == null || shopName.isEmpty) return false;

  final api = ref.watch(apiServiceProvider);
  final response = await api.get(
    '/redemption/customer-redemptions',
    queryParameters: {
      'isRedeemed': 'true',
      'searchTerm': shopName,
      'timeframe': 'today',
    },
  );

  if (response.data != null && response.data['success'] == true) {
    final rawList = response.data['data'] as List<dynamic>? ?? [];
    return rawList.isNotEmpty;
  }
  return false;
});

/// Simple local override — used by the shop owner scan flow to mark drink used
/// without waiting for a network round-trip.
final isDrinkRedeemedProvider = StateProvider<bool>((ref) => false);

import 'package:flutter_riverpod/legacy.dart';

final becomeSellerStepProvider = StateProvider<int>((ref) => 0);

final sellerCategoriesProvider = StateProvider<List<String>>((ref) => []);

final idFrontProvider = StateProvider<String?>((ref) => null);
final idBackProvider = StateProvider<String?>((ref) => null);

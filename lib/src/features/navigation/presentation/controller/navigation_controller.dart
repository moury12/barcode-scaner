import 'package:flutter_riverpod/legacy.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
final navigationProvider = StateProvider<int>((ref) => 0);
class NavigationController {
  static void changeIndex(WidgetRef ref, int index) {
    ref.read(navigationProvider.notifier).state = index;
  }
}
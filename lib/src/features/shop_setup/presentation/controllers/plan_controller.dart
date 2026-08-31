import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ShopPlan { starter, professional, enterprise }

class PlanNotifier extends Notifier<ShopPlan> {
  @override
  ShopPlan build() => ShopPlan.professional;

  void selectPlan(ShopPlan plan) => state = plan;
}

final planProvider =
    NotifierProvider<PlanNotifier, ShopPlan>(PlanNotifier.new);

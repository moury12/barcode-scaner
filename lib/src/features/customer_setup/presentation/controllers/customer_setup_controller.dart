import 'package:flutter_riverpod/flutter_riverpod.dart';

enum JoinStatus { initial, pending, active }

class CustomerSetupNotifier extends Notifier<JoinStatus> {
  @override
  JoinStatus build() => JoinStatus.initial;

  void sendRequest() => state = JoinStatus.pending;

  void approveRequest() => state = JoinStatus.active;
}

final customerSetupProvider =
    NotifierProvider<CustomerSetupNotifier, JoinStatus>(CustomerSetupNotifier.new);

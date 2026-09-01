import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRedeemed = ref.watch(isDrinkRedeemedProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(name: "John"),
              space16H,
              DrinkStatusCard(
                isAvailable: !isRedeemed,
                onShowCode: () => ref.read(navigationProvider.notifier).state = 1,
              ),
              space16H,
              const MembershipDetailsCard(),
              space24H,
              const RecentActivityList(),
            ],
          ),
        ),
      ),
    );
  }
}

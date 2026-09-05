import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRedeemed = ref.watch(isDrinkRedeemedProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CustomNetworkImage(imageUrl: "", boxShape: BoxShape.circle),
        ),
        title: Text("User Name"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12H(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "Welcome to Heritage & Hearth",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              space4H,
              DrinkStatusCard(
                isAvailable: !isRedeemed,
                onShowCode: () =>
                    ref.read(navigationProvider.notifier).state = 1,
              ),
              space12H,
              const MembershipDetailsCard(),
              space12H,
              const RecentActivityList(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRedeemed = ref.watch(isDrinkRedeemedProvider);
    final myMembershipsState = ref.watch(myMembershipsProvider);
    final selectedMembership = ref.watch(selectedMembershipProvider);
    final memberships = myMembershipsState.memberships;
    final userProfileState = ref.watch(userProfileProvider);

    final userImg = userProfileState.profile?.profileImg ?? "";

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: (userImg.isNotEmpty)
              ? ClipOval(
                  child: CustomNetworkImage(
                    imageUrl: userImg,
                    height: 80,
                    width: 80,
                    boxShape: BoxShape.circle,
                  ),
                )
              : CustomNetworkImage(imageUrl: "", boxShape: BoxShape.circle),
        ),
        title: const Text("Customer Dashboard"),
        centerTitle: false,
        // actions: [
        //   IconButton(
        //     onPressed: () => context.push(AppRoutes.notification),
        //     icon: const Icon(Icons.notifications_outlined, color: Colors.black),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(myMembershipsProvider.notifier).fetchMyMemberships();
            await ref.read(userProfileProvider.notifier).fetchProfile();
            // await ref.read(isDrinkRedeemedProvider.notifier).state = false;
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: AppPadding.getPadding12H(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Welcome to Heritage & Hearth",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                space8H,

                // If customer has multiple active memberships, show shop switcher chips
                if (memberships.length > 1) ...[
                  SizedBox(
                    height: 38,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: memberships.length,
                      separatorBuilder: (context, index) => space8W,
                      itemBuilder: (context, index) {
                        final item = memberships[index];
                        final isSelected = selectedMembership?.id == item.id;
                        return ChoiceChip(
                          label: CustomText(
                            item.shopName,
                            color: isSelected
                                ? Colors.white
                                : AppColors.kTextColor,
                            variant: TextVariant.labelSmall,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          selected: isSelected,
                          selectedColor: AppColors.kPrimaryColor,
                          backgroundColor: Colors.grey.shade100,
                          onSelected: (val) {
                            if (val) {
                              ref
                                  .read(myMembershipsProvider.notifier)
                                  .selectMembership(item);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  space12H,
                ],

                DrinkStatusCard(
                  isAvailable: !isRedeemed,
                  shopName: selectedMembership?.shopName,
                  onShowCode: () {
                    ref.read(isDrinkRedeemedProvider.notifier).state = true;
                    ref.read(navigationProvider.notifier).state = 1;
                  },
                ),
                space12H,
                MembershipDetailsCard(membership: selectedMembership),
                space12H,
                const RecentActivityList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

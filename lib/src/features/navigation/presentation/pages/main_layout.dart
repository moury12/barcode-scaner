import '../../../../src_export.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});
  static const List<Widget> _screens = [
    // HomePage(),
    // CategoryPage(),
    // SellerHubPage(),
    // CartPage(),
    // ProfilePage(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(navigationProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.kBackgroundColor,
        selectedItemColor: AppColors.kTextColor,
        unselectedItemColor: AppColors.kTextColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          _navItem(AppAssets.home, AppAssets.home2, 'Home'),
          _navItem(AppAssets.searchStatus, AppAssets.searchStatus2, 'Category'),
          _navItem(AppAssets.category, AppAssets.sellerHubFill, 'Seller Hub'),
          _navItem(AppAssets.shoppingCart, AppAssets.shoppingCartFill, 'Cart'),
          _navItem(AppAssets.profile, AppAssets.profileFill, 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(String asset, String asset2, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          asset,
          height: 25,
          colorFilter: const ColorFilter.mode(
            AppColors.kTextColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          asset2,
          height: 25,
          // colorFilter: const ColorFilter.mode(
          //   AppColors.kTextColor,
          //   BlendMode.srcIn,
          // ),
        ),
      ),
      label: label,
    );
  }
}
*/


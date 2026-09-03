import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    final role = ref.watch(onboardingRoleProvider) ?? 'customer';
    final isShopOwner = role == 'shop_owner';

    final List<Widget> screens = isShopOwner 
      ? [const ShopDashboardPage(), const ScannerPage(), const CustomerListPage(), const ShopProfileTab()] // Shop owner screens
      : [const HomePage(), const QrCodePage(), const HistoryPage(), const ProfilePage()]; // Customer screens

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(navigationProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.kSetupButtonColor,
        unselectedItemColor: AppColors.kBrownTextColor,
        items: isShopOwner ? _shopOwnerItems() : _customerItems(),
      ),
    );
  }

  List<BottomNavigationBarItem> _customerItems() => [
    _navItem(AppStaticStrings.homeNav, 'Home'),
    _navItem(AppStaticStrings.scanNav, 'My Code'),
    _navItem(AppStaticStrings.historyNav, 'History'),
    _navItem(AppStaticStrings.profileNav, 'Profile'),
  ];

  List<BottomNavigationBarItem> _shopOwnerItems() => [
    _navItem('assets/icons/dashboard_nav_icon.svg', 'Dashboard'),
    _navItem('assets/icons/scan_nav_icon.svg', 'Scan'),
    _navItem('assets/icons/customer_nav_icon.svg', 'Customers'),
    _navItem(AppStaticStrings.profileNav, 'Profile'),
  ];

  BottomNavigationBarItem _navItem(String asset, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(asset, height: 20, colorFilter: const ColorFilter.mode(AppColors.kBrownTextColor, BlendMode.srcIn)),
      activeIcon: SvgPicture.asset(asset, height: 20, colorFilter: const ColorFilter.mode(AppColors.kSetupButtonColor, BlendMode.srcIn)),
      label: label,
    );
  }
}

// lib/src/features/navigation/presentation/pages/main_layout.dart

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
        ? [
            const ShopDashboardPage(),
            const ScannerPage(),
            const CustomerListPage(),
            const ShopProfileTab(),
          ]
        : [
            const HomePage(),
            const QrCodePage(),
            const HistoryPage(),
            const ProfilePage(),
          ];

    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade100)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) => ref.read(navigationProvider.notifier).state = index,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          // CRITICAL: Set font sizes to 0 to remove label space
          selectedFontSize: 0,
          unselectedFontSize: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: isShopOwner ? _shopOwnerItems() : _customerItems(),
        ),
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
      // UNSELECTED STATE
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            asset,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.kPrimaryColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          CustomText(
            label,
            variant: TextVariant.labelSmall,
            color: AppColors.kPrimaryColor,
            fontSize: 10,
          ),
        ],
      ),
      // SELECTED STATE (The Pill)
      activeIcon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              asset,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.kBackgroundColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            CustomText(
              label,
              variant: TextVariant.labelSmall,
              color: AppColors.kBackgroundColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
      label: '', // Empty because we are rendering text inside the icon widget
    );
  }
}

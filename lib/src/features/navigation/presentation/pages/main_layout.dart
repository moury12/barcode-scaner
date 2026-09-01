import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../src_export.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  static const List<Widget> _screens = [
    HomePage(),
    QrCodePage(),
    HistoryPage(),
    ProfilePage(),
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
        selectedItemColor: const Color(0xFF536148),
        unselectedItemColor: AppColors.kBrownTextColor,
        items: [
          _navItem(AppStaticStrings.homeNav, 'Home'),
          _navItem(AppStaticStrings.scanNav, 'My Code'),
          _navItem(AppStaticStrings.historyNav, 'History'),
          _navItem(AppStaticStrings.profileNav, 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _navItem(String asset, String label) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          asset,
          height: 20,
          colorFilter: const ColorFilter.mode(
            AppColors.kBrownTextColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: SvgPicture.asset(
          asset,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Color(0xFF536148),
            BlendMode.srcIn,
          ),
        ),
      ),
      label: label,
    );
  }
}

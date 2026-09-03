import '../../../../src_export.dart';

class CustomerListPage extends StatelessWidget {
  const CustomerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText("Customers", variant: TextVariant.titleLarge),
          bottom: const TabBar(
            tabs: [Tab(text: "Active"), Tab(text: "Pending")],
            indicatorColor: AppColors.kSetupButtonColor,
            labelColor: AppColors.kSetupButtonColor,
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: AppPadding.getPadding12(context),
              child: const CustomTextField(
                hintText: "Search customers...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  CustomerListPageListView(status: "Active"),
                  CustomerListPageListView(status: "Pending"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../../src_export.dart';

class CustomerListPageListView extends StatelessWidget {
  final String status;

  const CustomerListPageListView({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: AppPadding.getPadding12(context),
      itemCount: 4,
      separatorBuilder: (context, index) => space8H,
      itemBuilder: (context, index) => CustomerListTile(
        name: status == "Active" ? "Julianna Vane" : "Marcus Thorne",
        joinDate: "Oct 12, 2023",
        status: status,
        onTap: () => context.push(status == "Active" ? AppRoutes.customerDetails : AppRoutes.customerRequest),
      ),
    );
  }
}

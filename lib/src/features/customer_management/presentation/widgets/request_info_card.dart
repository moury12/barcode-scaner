import '../../../../src_export.dart';

class RequestInfoCard extends StatelessWidget {
  final String requestDate;
  final String plan;

  const RequestInfoCard({
    super.key,
    required this.requestDate,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          CustomerInfoRow(icon: Icons.calendar_today_outlined, label: "Request Date", value: requestDate),
          const Divider(height: 24),
          CustomerInfoRow(icon: Icons.card_membership, label: "Requested Plan", value: plan),
        ],
      ),
    );
  }
}

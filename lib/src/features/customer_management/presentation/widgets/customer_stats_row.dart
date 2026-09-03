import '../../../../src_export.dart';

class CustomerStatsRow extends StatelessWidget {
  final String totalRedemptions;
  final String latestRedemption;

  const CustomerStatsRow({
    super.key,
    required this.totalRedemptions,
    required this.latestRedemption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: StatBox(label: "Total Redemptions", value: totalRedemptions)),
        space12W,
        Expanded(child: StatBox(label: "Latest", value: latestRedemption)),
      ],
    );
  }
}

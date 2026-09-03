import '../../../../src_export.dart';

class CustomerInfoCard extends StatelessWidget {
  final String email;
  final String phone;

  const CustomerInfoCard({
    super.key,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CustomerInfoRow(icon: Icons.email_outlined, label: "Email", value: email),
          const Divider(height: 32),
          CustomerInfoRow(icon: Icons.phone_outlined, label: "Phone", value: phone),
        ],
      ),
    );
  }
}

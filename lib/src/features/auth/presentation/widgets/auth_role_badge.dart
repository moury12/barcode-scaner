import '../../../../src_export.dart';

class AuthRoleBadge extends StatelessWidget {
  final String role;
  const AuthRoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final isCustomer = role == 'customer';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isCustomer ? Icons.person_outline : Icons.storefront_outlined, size: 14),
          space4W,
          CustomText(
            isCustomer ? 'CUSTOMER' : 'SHOP OWNER', 
            fontSize: 10, 
            fontWeight: FontWeight.bold, 
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../src_export.dart';

class CustomerRequestPage extends ConsumerStatefulWidget {
  final CustomerMembershipModel? customer;

  const CustomerRequestPage({super.key, this.customer});

  @override
  ConsumerState<CustomerRequestPage> createState() => _CustomerRequestPageState();
}

class _CustomerRequestPageState extends ConsumerState<CustomerRequestPage> {
  String _formatDate(DateTime? dt) {
    if (dt == null) return 'N/A';
    try {
      return DateFormat('MMM dd, yyyy').format(dt);
    } catch (_) {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  Future<void> _activateCustomer() async {
    final customer = widget.customer;
    if (customer == null || customer.id.isEmpty) return;

    final success = await ref
        .read(customerManagementProvider.notifier)
        .updateStatus(membershipId: customer.id, newStatus: 'active');

    if (mounted) {
      if (success) {
        context.push(
          AppRoutes.confirmActivation,
          extra: {'customerName': customer.customerName},
        );
      } else {
        final err = ref.read(customerManagementProvider).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err ?? 'Failed to activate customer'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _declineCustomer() async {
    final customer = widget.customer;
    if (customer == null || customer.id.isEmpty) return;

    final success = await ref
        .read(customerManagementProvider.notifier)
        .updateStatus(membershipId: customer.id, newStatus: 'rejected');

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request declined successfully'),
            backgroundColor: Colors.orange,
          ),
        );
        context.pop();
      } else {
        final err = ref.read(customerManagementProvider).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err ?? 'Failed to decline request'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.customer;
    final state = ref.watch(customerManagementProvider);

    if (customer == null) {
      return Scaffold(
        appBar: AppBar(title: const CustomText("Activation Request")),
        body: const Center(child: CustomText("No customer request data found.")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText("Activation Request", variant: TextVariant.titleLarge),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: customer.customerImg.isNotEmpty
                  ? NetworkImage(customer.customerImg)
                  : null,
              child: customer.customerImg.isEmpty
                  ? const Icon(Icons.person, size: 48, color: Colors.grey)
                  : null,
            ),
            space12H,
            CustomText(
              customer.customerName.isNotEmpty ? customer.customerName : 'Unnamed Customer',
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            space4H,
            const CustomText("Pending Approval", color: AppColors.kAccentColor, fontWeight: FontWeight.bold),
            space24H,
            ActivationBannerCard(
              customerName: customer.customerName.isNotEmpty ? customer.customerName : 'Customer',
            ),
            space16H,
            CustomerInfoCard(
              email: customer.customerEmail.isNotEmpty ? customer.customerEmail : 'N/A',
              phone: customer.customerPhone.isNotEmpty ? customer.customerPhone : 'N/A',
            ),
            space16H,
            RequestInfoCard(
              requestDate: _formatDate(customer.createdAt),
              plan: "Standard Member",
            ),
            space24H,
            if (state.isUpdatingStatus)
              const Center(child: CircularProgressIndicator())
            else ...[
              CustomButton(
                text: "Activate Customer",
                backgroundColor: AppColors.kSetupButtonColor,
                onPressed: _activateCustomer,
              ),
              space12H,
              CustomButton(
                text: "Decline Request",
                isOutlined: true,
                textColor: Colors.red,
                borderColor: Colors.red.withValues(alpha: 0.3),
                onPressed: _declineCustomer,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../src_export.dart';

class CustomerDetailsPage extends ConsumerStatefulWidget {
  final CustomerMembershipModel? customer;

  const CustomerDetailsPage({super.key, this.customer});

  @override
  ConsumerState<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends ConsumerState<CustomerDetailsPage> {
  late CustomerMembershipModel? _customer;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return 'N/A';
    try {
      return DateFormat('MMM dd, yyyy - hh:mm a').format(dt);
    } catch (_) {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.kGreenColor;
      case 'pending':
        return AppColors.kAccentColor;
      case 'paused':
        return Colors.blueGrey;
      case 'rejected':
        return Colors.red;
      default:
        return AppColors.kGreenColor;
    }
  }

  Future<void> _handleUpdateStatus(String newStatus) async {
    final customer = _customer;
    if (customer == null || customer.id.isEmpty) return;

    final success = await ref
        .read(customerManagementProvider.notifier)
        .updateStatus(membershipId: customer.id, newStatus: newStatus);

    if (mounted) {
      if (success) {
        setState(() {
          _customer = customer.copyWith(status: newStatus.toLowerCase());
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Status updated to $newStatus successfully'),
            backgroundColor: AppColors.kGreenColor,
          ),
        );
      } else {
        final err = ref.read(customerManagementProvider).errorMessage;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err ?? 'Failed to update status'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerManagementProvider);
    final customer = _customer;

    if (customer == null) {
      return Scaffold(
        appBar: AppBar(title: const CustomText("Customer Details")),
        body: const Center(child: CustomText("No customer selected.")),
      );
    }

    final status = customer.status;
    final statusColor = _getStatusColor(status);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText("Customer Details", variant: TextVariant.titleLarge),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (val) => _handleUpdateStatus(val),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'active', child: Text('Mark Active')),
              const PopupMenuItem(value: 'paused', child: Text('Mark Paused')),
              const PopupMenuItem(value: 'rejected', child: Text('Mark Rejected')),
            ],
          ),
        ],
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: CustomText(
                status.toUpperCase(),
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            space24H,
            CustomerInfoCard(
              email: customer.customerEmail.isNotEmpty ? customer.customerEmail : 'N/A',
              phone: customer.customerPhone.isNotEmpty ? customer.customerPhone : 'N/A',
            ),
            space16H,
            Container(
              padding: AppPadding.getPadding16(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  CustomerInfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: "Joined / Requested Date",
                    value: _formatDate(customer.createdAt),
                  ),
                  if (customer.updatedAt != null) ...[
                    const Divider(height: 24),
                    CustomerInfoRow(
                      icon: Icons.update,
                      label: "Last Updated",
                      value: _formatDate(customer.updatedAt),
                    ),
                  ],
                ],
              ),
            ),
            space24H,
            if (state.isUpdatingStatus)
              const Center(child: CircularProgressIndicator())
            else
              ..._buildActionButtons(status),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return [
          CustomButton(
            text: "Activate Customer",
            backgroundColor: AppColors.kSetupButtonColor,
            onPressed: () => _handleUpdateStatus('active'),
          ),
          space12H,
          CustomButton(
            text: "Reject Request",
            isOutlined: true,
            textColor: Colors.red,
            borderColor: Colors.red.withValues(alpha: 0.3),
            onPressed: () => _handleUpdateStatus('rejected'),
          ),
        ];
      case 'active':
        return [
          CustomButton(
            text: "Pause Membership",
            isOutlined: true,
            textColor: AppColors.kAccentColor,
            borderColor: AppColors.kAccentColor.withValues(alpha: 0.5),
            onPressed: () => _handleUpdateStatus('paused'),
          ),
          space12H,
          CustomButton(
            text: "Reject / Deactivate",
            isOutlined: true,
            textColor: Colors.red,
            borderColor: Colors.red.withValues(alpha: 0.3),
            onPressed: () => _handleUpdateStatus('rejected'),
          ),
        ];
      case 'paused':
        return [
          CustomButton(
            text: "Resume / Activate Membership",
            backgroundColor: AppColors.kSetupButtonColor,
            onPressed: () => _handleUpdateStatus('active'),
          ),
          space12H,
          CustomButton(
            text: "Reject Membership",
            isOutlined: true,
            textColor: Colors.red,
            borderColor: Colors.red.withValues(alpha: 0.3),
            onPressed: () => _handleUpdateStatus('rejected'),
          ),
        ];
      case 'rejected':
        return [
          CustomButton(
            text: "Re-Activate Customer",
            backgroundColor: AppColors.kSetupButtonColor,
            onPressed: () => _handleUpdateStatus('active'),
          ),
        ];
      default:
        return [
          CustomButton(
            text: "Activate Customer",
            backgroundColor: AppColors.kSetupButtonColor,
            onPressed: () => _handleUpdateStatus('active'),
          ),
        ];
    }
  }
}

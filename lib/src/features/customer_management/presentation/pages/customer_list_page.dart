import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../src_export.dart';

class CustomerListPage extends ConsumerStatefulWidget {
  const CustomerListPage({super.key});

  @override
  ConsumerState<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends ConsumerState<CustomerListPage>
    with SingleTickerProviderStateMixin {
  static const List<String> _statuses = ['active', 'pending', 'paused', 'rejected'];
  static const List<String> _tabLabels = ['Active', 'Pending', 'Paused', 'Rejected'];

  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _statuses.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final newStatus = _statuses[_tabController.index];
    ref.read(customerManagementProvider.notifier).setStatusTab(newStatus);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(customerManagementProvider.notifier).loadMore();
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      ref.read(customerManagementProvider.notifier).search(value);
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    try {
      return DateFormat('MMM dd, yyyy').format(dt);
    } catch (_) {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerManagementProvider);

    return Scaffold(
      appBar: AppBar(
        title: const CustomText("Customers", variant: TextVariant.titleLarge),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          indicatorColor: AppColors.kSetupButtonColor,
          labelColor: AppColors.kSetupButtonColor,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: AppPadding.getPadding12(context),
            child: CustomTextField(
              textEditingController: _searchController,
              hintText: "Search customers by name, email, phone...",
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(customerManagementProvider.notifier).search('');
                        setState(() {});
                      },
                    )
                  : null,
              onChanged: (val) {
                setState(() {});
                _onSearchChanged(val);
              },
            ),
          ),
          Expanded(
            child: _buildBody(state),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CustomerListState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              space12H,
              CustomText(
                state.errorMessage!,
                textAlign: TextAlign.center,
                color: AppColors.kBrownTextColor,
              ),
              space16H,
              CustomButton(
                text: 'Retry',
                backgroundColor: AppColors.kPrimaryColor,
                onPressed: () => ref.read(customerManagementProvider.notifier).refresh(),
              ),
            ],
          ),
        ),
      );
    }

    if (state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.people_outline, size: 54, color: Colors.grey.shade400),
            space12H,
            CustomText(
              "No ${state.status} customers found.",
              color: AppColors.kBrownTextColor,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(customerManagementProvider.notifier).refresh(),
      child: ListView.separated(
        controller: _scrollController,
        padding: AppPadding.getPadding12(context),
        itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => space8H,
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final customer = state.items[index];
          return CustomerListTile(
            name: customer.customerName,
            joinDate: _formatDate(customer.createdAt),
            status: customer.status,
            imageUrl: customer.customerImg,
            onTap: () {
              if (customer.status.toLowerCase() == 'pending') {
                context.push(
                  AppRoutes.customerRequest,
                  extra: {'customer': customer},
                );
              } else {
                context.push(
                  AppRoutes.customerDetails,
                  extra: {'customer': customer},
                );
              }
            },
          );
        },
      ),
    );
  }
}

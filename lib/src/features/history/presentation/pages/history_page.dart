import '../../../../src_export.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedFilter = "All";

  final List<Map<String, String>> _allHistory = const [
    {
      "shop": "Coffee House Zürich",
      "date": "Today, 08:30 AM",
      "status": "Redeemed",
    },
    {
      "shop": "Coffee House Zürich",
      "date": "Aug 29, 10:32 AM",
      "status": "Redeemed",
    },
    {
      "shop": "Brew & Bean Co.",
      "date": "Aug 27, 02:15 PM",
      "status": "Redeemed",
    },
    {
      "shop": "Espresso Lab",
      "date": "Aug 20, 09:10 AM",
      "status": "Redeemed",
    },
    {
      "shop": "Coffee House Zürich",
      "date": "Aug 15, 11:45 AM",
      "status": "Redeemed",
    },
  ];

  List<Map<String, String>> get _filteredHistory {
    if (_selectedFilter == "This Week") {
      return _allHistory.take(2).toList();
    } else if (_selectedFilter == "This Month") {
      return _allHistory.take(4).toList();
    }
    return _allHistory;
  }

  @override
  Widget build(BuildContext context) {
    final historyList = _filteredHistory;

    return Scaffold(
      appBar: AppBar(
        title: const CustomText("History", variant: TextVariant.titleLarge),
      ),
      body: Column(
        children: [
          _filterTabs(),
          space12H,
          Expanded(
            child: historyList.isEmpty
                ? const Center(
                    child: CustomText(
                      "No history for this period.",
                      color: AppColors.kBrownTextColor,
                    ),
                  )
                : ListView.separated(
                    padding: AppPadding.getPadding12(context),
                    itemCount: historyList.length,
                    separatorBuilder: (_, _) => space12H,
                    itemBuilder: (context, index) {
                      final item = historyList[index];
                      return _historyTile(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterTabs() {
    final filters = ["All", "This Week", "This Month"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: filters.map((label) {
          final isSelected = label == _selectedFilter;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedFilter = label;
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF536148) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF536148) : Colors.grey.shade300,
                  ),
                ),
                child: CustomText(
                  label,
                  color: isSelected ? Colors.white : AppColors.kTextColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _historyTile(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFF1F1F1),
            child: Icon(Icons.coffee, size: 18, color: AppColors.kTextColor),
          ),
          space12W,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(item["shop"] ?? "", fontWeight: FontWeight.bold),
                CustomText(
                  item["date"] ?? "",
                  variant: TextVariant.bodySmall,
                  color: AppColors.kBrownTextColor,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0E8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomText(
              item["status"] ?? "Redeemed",
              fontSize: 10,
              color: const Color(0xFF536148),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

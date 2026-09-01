import '../../../../src_export.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText("History", variant: TextVariant.titleLarge),
      ),
      body: Column(
        children: [
          _filterTabs(),
          Expanded(
            child: ListView.separated(
              padding: AppPadding.getPadding12(context),
              itemCount: 5,
              separatorBuilder: (_, _) => space12H,
              itemBuilder: (context, index) => _historyTile(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: ["All", "This Week", "This Month"].map((label) {
          bool isSelected = label == "All";
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Chip(
              label: CustomText(
                label,
                color: isSelected ? Colors.white : AppColors.kTextColor,
              ),
              backgroundColor:
                  isSelected ? const Color(0xFF536148) : Colors.white,
              side: BorderSide(color: Colors.grey.shade200),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _historyTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFF1F1F1),
            child: Icon(Icons.coffee, size: 18, color: AppColors.kTextColor),
          ),
          space12W,
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("Coffee House Zürich", fontWeight: FontWeight.bold),
                CustomText(
                  "Aug 29, 10:32 AM",
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
            child: const CustomText(
              "Redeemed",
              fontSize: 10,
              color: Color(0xFF536148),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

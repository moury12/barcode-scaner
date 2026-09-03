import '../../../../src_export.dart';

class RedemptionHistoryPage extends StatefulWidget {
  const RedemptionHistoryPage({super.key});

  @override
  State<RedemptionHistoryPage> createState() => _RedemptionHistoryPageState();
}

class _RedemptionHistoryPageState extends State<RedemptionHistoryPage> {
  String _selectedFilter = "Today";

  final List<String> _filters = ["Today", "This Week", "This Month"];

  final List<Map<String, String>> _redemptions = const [
    {
      "name": "Julianna Vane",
      "drink": "Oat Milk Latte",
      "time": "10:42 AM",
      "image": "https://i.pravatar.cc/150?img=32",
    },
    {
      "name": "Marcus Thorne",
      "drink": "Cortado",
      "time": "09:15 AM",
      "image": "https://i.pravatar.cc/150?img=12",
    },
    {
      "name": "Sarah Connor",
      "drink": "Iced Flat White",
      "time": "Yesterday, 04:30 PM",
      "image": "https://i.pravatar.cc/150?img=47",
    },
    {
      "name": "David Miller",
      "drink": "Espresso Single",
      "time": "Yesterday, 02:10 PM",
      "image": "https://i.pravatar.cc/150?img=60",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText("Redemption History", variant: TextVariant.titleLarge),
      ),
      body: Column(
        children: [
          space12H,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: AppPadding.getPadding12H(context),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = filter == _selectedFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.kSetupButtonColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.kTextColor,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedFilter = filter);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          space12H,
          Expanded(
            child: ListView.separated(
              padding: AppPadding.getPadding12(context),
              itemCount: _redemptions.length,
              separatorBuilder: (context, index) => space8H,
              itemBuilder: (context, index) {
                final item = _redemptions[index];
                return RedemptionHistoryTile(
                  customerName: item["name"]!,
                  drinkName: item["drink"]!,
                  timestamp: item["time"]!,
                  imageUrl: item["image"]!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

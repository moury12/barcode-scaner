import '../../../../src_export.dart';

class HoursRow extends StatelessWidget {
  final String day;
  final String time;

  const HoursRow({
    super.key,
    required this.day,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          day,
          variant: TextVariant.bodyMedium,
          color: AppColors.kBrownTextColor,
        ),
        CustomText(
          time,
          variant: TextVariant.bodyMedium,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}

class OpeningHoursCard extends StatelessWidget {
  final List<Map<String, String>>? hours;

  const OpeningHoursCard({
    super.key,
    this.hours,
  });

  @override
  Widget build(BuildContext context) {
    final schedule = hours ?? [
      {"day": "Monday - Friday", "time": "7:00 AM - 6:00 PM"},
      {"day": "Saturday", "time": "8:00 AM - 6:00 PM"},
      {"day": "Sunday", "time": "8:00 AM - 5:00 PM"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Opening Hours",
          variant: TextVariant.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        space8H,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              for (int i = 0; i < schedule.length; i++) ...[
                if (i > 0) const Divider(height: 16),
                HoursRow(
                  day: schedule[i]["day"] ?? "",
                  time: schedule[i]["time"] ?? "",
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

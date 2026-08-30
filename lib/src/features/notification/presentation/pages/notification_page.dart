import '../../../../src_export.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock notifications for demonstration
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Raffle Winner! 🏆',
        'message': 'Congratulations! You won the Sneaker Head draw. Check your active orders to claim it.',
        'time': '2 mins ago',
        'type': 'raffle',
        'isRead': false,
      },
      {
        'title': 'Seller Live Now 🔴',
        'message': 'RetroKicks is live streaming: "Rare Jordan 1s Drop & Auction!" Join now.',
        'time': '1 hour ago',
        'type': 'live',
        'isRead': false,
      },
      {
        'title': 'Order Dispatched 📦',
        'message': 'Your order #PK-88492 has been dispatched via Royal Mail. Track delivery status.',
        'time': 'Yesterday',
        'type': 'order',
        'isRead': true,
      },
      {
        'title': 'Promo Code Added 🎟️',
        'message': 'Use code POKELIVE10 for 10% off on your next purchase. Valid for 48 hours.',
        'time': '3 days ago',
        'type': 'promo',
        'isRead': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const CustomText(
          'Notifications',
          variant: TextVariant.headlineMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All notifications marked as read'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const CustomText(
              'Mark all read',
              variant: TextVariant.bodyMedium,
              color: AppColors.kAccentColor,
            ),
          ),
          space8W,
        ],
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: AppColors.kGreyTextColor.withOpacity(0.5),
                  ),
                  space16H,
                  const CustomText(
                    'No notifications yet',
                    variant: TextVariant.titleLarge,
                  ),
                  space8H,
                  const CustomText(
                    'We will notify you when something important happens.',
                    variant: TextVariant.bodyMedium,
                    color: AppColors.kGreyTextColor,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: AppPadding.getPadding12(context),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => space12H,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationCard({
    super.key,
    required this.notification,
  });

  IconData _getIconForType(String type) {
    switch (type) {
      case 'raffle':
        return Icons.emoji_events_outlined;
      case 'live':
        return Icons.live_tv_outlined;
      case 'order':
        return Icons.local_shipping_outlined;
      case 'promo':
        return Icons.local_offer_outlined;
      default:
        return Icons.notifications_none_outlined;
    }
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'raffle':
        return AppColors.kYellowColor;
      case 'live':
        return AppColors.kRedColor;
      case 'order':
        return AppColors.kGreenColor;
      case 'promo':
        return AppColors.kAccentColor;
      default:
        return AppColors.kTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isRead = notification['isRead'] as bool;
    final String type = notification['type'] as String;

    return Container(
      decoration: BoxDecoration(
        color: isRead ? Colors.transparent : AppColors.kPrimaryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(appRadius),
        border: Border.all(
          color: isRead ? AppColors.kBorderColor.withOpacity(0.3) : AppColors.kPrimaryColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getColorForType(type).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconForType(type),
              color: _getColorForType(type),
              size: 24,
            ),
          ),
          space12W,
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        notification['title'] as String,
                        variant: TextVariant.titleMedium,
                        fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    CustomText(
                      notification['time'] as String,
                      variant: TextVariant.bodySmall,
                      color: AppColors.kGreyTextColor,
                    ),
                  ],
                ),
                space4H,
                CustomText(
                  notification['message'] as String,
                  variant: TextVariant.bodyMedium,
                  color: isRead ? AppColors.kGreyTextColor : AppColors.kTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import '../../../../src_export.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ButtonTapWidget(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Icon(icon, color: isDestructive ? Colors.red : AppColors.kTextColor, size: 20),
              space12W,
              Expanded(
                child: CustomText(
                  title,
                  color: isDestructive ? Colors.red : AppColors.kTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!isDestructive) const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

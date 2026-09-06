import '../../../../src_export.dart';

class StatusIconHeader extends StatelessWidget {
  final bool isRedeemed; // true for Success, false for Already Redeemed
  const StatusIconHeader({super.key, this.isRedeemed = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isRedeemed
            ? const Color(0xFFF1F5F1)
            : const Color(0xFFE8F0E8).withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF536148),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 32),
      ),
    );
  }
}

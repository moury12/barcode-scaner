import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ── ButtonTapWidget ──────────────────────────────────────
class ButtonTapWidget extends StatelessWidget {
  const ButtonTapWidget({
    super.key,
    required this.child,
    this.onTap,
    this.radius,
    this.shape,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double? radius;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: shape,
        splashColor: AppColors.kAccentColor.withValues(alpha: .2),
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? 12),
        child: child,
      ),
    );
  }
}

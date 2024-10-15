import 'package:flutter/material.dart';
import 'package:meus_fiis/shared/n_utils/utils/n_spacing.dart';

class NButton extends StatelessWidget {
  const NButton({
    super.key,
    this.onTap,
    this.enabled = true,
    this.child,
    this.radius = NSpacing.zero,
    this.color,
    this.animationColor,
    this.disabledColor,
    this.padding,
    this.elevation = NSpacing.zero,
  });

  final VoidCallback? onTap;
  final Widget? child;
  final bool enabled;
  final double radius;
  final Color? animationColor;
  final Color? color;
  final Color? disabledColor;
  final EdgeInsets? padding;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(radius),
        highlightColor: animationColor?.withOpacity(0.10),
        splashColor: animationColor?.withOpacity(0.10),
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            color: enabled ? color : (disabledColor ?? color),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: child,
        ),
      ),
    );
  }
}

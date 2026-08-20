import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'adaptive_size.dart';

class AdaptiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? elevation;
  final Color? shadowColor;
  final double? maxWidth;
  final VoidCallback? onTap;

  const AdaptiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.elevation,
    this.shadowColor,
    this.maxWidth = 550,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? (context.isSmallScreen ? 18.0 : 24.0);
    final cardPadding = padding ?? EdgeInsets.all(context.wp(context.isSmallScreen ? 5.0 : 6.5));

    Widget cardContent = Container(
      margin: margin,
      padding: cardPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.cardWhite,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: (shadowColor ?? AppColors.navyBlue).withValues(alpha: 0.08),
            blurRadius: elevation ?? 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: cardContent,
        ),
      );
    }

    if (maxWidth != null) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth!),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }
}

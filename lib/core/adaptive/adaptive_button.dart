import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'adaptive_size.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final IconData? icon;
  final bool isLoading;

  const AdaptiveButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final btnHeight = height ?? (context.isSmallScreen ? 48.0 : 54.0);
    final btnRadius = borderRadius ?? 16.0;
    final btnFontSize = fontSize ?? context.sp(15.5);

    return SizedBox(
      height: btnHeight,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.accentBlue,
          foregroundColor: foregroundColor ?? Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: context.wp(4)),
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: btnFontSize + 4),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: btnFontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

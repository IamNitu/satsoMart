import 'package:flutter/material.dart';

class AdaptiveSize {
  AdaptiveSize._();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double height(BuildContext context) => MediaQuery.sizeOf(context).height;

  static double wp(BuildContext context, double percent) =>
      width(context) * (percent / 100);

  static double hp(BuildContext context, double percent) =>
      height(context) * (percent / 100);

  static double sp(BuildContext context, double size) {
    final w = width(context);
    final scale = (w / 390).clamp(0.85, 1.25);
    return size * scale;
  }

  static EdgeInsets horizontalPadding(BuildContext context, {double percent = 6.0}) {
    return EdgeInsets.symmetric(horizontal: wp(context, percent));
  }

  static bool isSmallScreen(BuildContext context) => width(context) < 375;
  static bool isTablet(BuildContext context) => width(context) >= 600;
}

extension AdaptiveContext on BuildContext {
  double get screenWidth => AdaptiveSize.width(this);
  double get screenHeight => AdaptiveSize.height(this);
  double wp(double percent) => AdaptiveSize.wp(this, percent);
  double hp(double percent) => AdaptiveSize.hp(this, percent);
  double sp(double size) => AdaptiveSize.sp(this, size);
  bool get isSmallScreen => AdaptiveSize.isSmallScreen(this);
  bool get isTablet => AdaptiveSize.isTablet(this);
}

import 'package:flutter/material.dart';
import 'adaptive_size.dart';

class AdaptiveContainer extends StatelessWidget {
  final Widget child;
  final double? widthPercent;
  final double? heightPercent;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  const AdaptiveContainer({
    super.key,
    required this.child,
    this.widthPercent,
    this.heightPercent,
    this.maxWidth = 600,
    this.maxHeight,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final double? calcWidth = widthPercent != null ? context.wp(widthPercent!) : null;
    final double? calcHeight = heightPercent != null ? context.hp(heightPercent!) : null;

    Widget content = Container(
      width: calcWidth,
      height: calcHeight,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      alignment: alignment,
      child: child,
    );

    if (maxWidth != null || maxHeight != null) {
      content = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: content,
      );
    }

    return content;
  }
}

import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const HomeSearchBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AdaptiveSize.horizontalPadding(context, percent: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(3.5),
            vertical: context.hp(1.4),
          ),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search_rounded,
                color: AppColors.textLight,
                size: context.sp(20),
              ),
              SizedBox(width: context.wp(2.5)),
              Expanded(
                child: Text(
                  "Search for phones, shoes, clothes...",
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: context.sp(13.5),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

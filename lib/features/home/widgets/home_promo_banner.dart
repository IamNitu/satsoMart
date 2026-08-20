import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AdaptiveSize.horizontalPadding(context, percent: 5),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(context.wp(5)),
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.wp(2.5),
                      vertical: context.hp(0.4),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "LIMITED OFFER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.sp(10),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(height: context.hp(1.0)),
                  Text(
                    "Flash Summer Sale",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: context.sp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: context.hp(0.4)),
                  Text(
                    "Up to 50% OFF on all top brands",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: context.sp(12),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.local_mall_rounded,
              color: Colors.white.withValues(alpha: 0.85),
              size: context.sp(44),
            ),
          ],
        ),
      ),
    );
  }
}

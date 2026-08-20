import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const HomeBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.wp(context.isTablet ? 20 : 5),
        right: context.wp(context.isTablet ? 20 : 5),
        bottom: context.hp(context.isSmallScreen ? 1.5 : 2.2),
      ),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyBlue.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(2.5),
            vertical: context.hp(1.0),
          ),
          child: GNav(
            rippleColor: Colors.grey.shade200,
            hoverColor: Colors.grey.shade100,
            gap: 8,
            activeColor: AppColors.accentBlue,
            iconSize: context.sp(22),
            padding: EdgeInsets.symmetric(
              horizontal: context.wp(3.5),
              vertical: context.hp(1.2),
            ),
            duration: const Duration(milliseconds: 350),
            tabBackgroundColor: AppColors.accentLight.withValues(alpha: 0.5),
            color: AppColors.textGrey,
            tabs: const [
              GButton(icon: Icons.home_rounded),
              GButton(icon: Icons.shopping_cart_outlined),
              GButton(icon: Icons.favorite_border_rounded),
              GButton(icon: Icons.person_outline_rounded),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}

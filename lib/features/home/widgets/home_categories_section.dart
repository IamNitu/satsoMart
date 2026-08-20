import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class HomeCategoriesSection extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const HomeCategoriesSection({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AdaptiveSize.horizontalPadding(context, percent: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  fontSize: context.sp(16),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                    fontSize: context.sp(13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.accentBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.hp(1.2)),
        SizedBox(
          height: context.hp(5.2),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AdaptiveSize.horizontalPadding(context, percent: 5),
            itemCount: categories.length,
            separatorBuilder: (context, index) => SizedBox(width: context.wp(2.5)),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              final cat = categories[index];
              return GestureDetector(
                onTap: () => onCategorySelected(index),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.wp(3.8),
                    vertical: context.hp(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.accentBlue : AppColors.cardWhite,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.accentBlue : AppColors.borderLight,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        cat["icon"] as IconData,
                        size: context.sp(16),
                        color: isSelected ? Colors.white : AppColors.textDark,
                      ),
                      SizedBox(width: context.wp(1.5)),
                      Text(
                        cat["name"] as String,
                        style: TextStyle(
                          fontSize: context.sp(12.5),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

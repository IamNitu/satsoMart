import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/core/api/api_endpoints.dart';

class PdpHeroGallery extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final int currentIndex;
  final double discountPercent;
  final ValueChanged<int> onPageChanged;

  const PdpHeroGallery({
    super.key,
    required this.images,
    required this.pageController,
    required this.currentIndex,
    required this.discountPercent,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.hp(context.isSmallScreen ? 35 : 38),
      width: double.infinity,
      color: const Color(0xFFF1F5F9), // Soft porcelain canvas
      child: Stack(
        children: [
          if (images.isNotEmpty)
            PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: context.hp(6.0),
                      bottom: context.hp(4.0),
                      left: context.wp(6),
                      right: context.wp(6),
                    ),
                    child: Image.network(
                      ApiEndpoints.imageUrl(images[index]),
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.accentBlue,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported_outlined,
                        size: context.sp(56),
                        color: AppColors.textLight,
                      ),
                    ),
                  ),
                );
              },
            )
          else
            Center(
              child: Icon(
                Icons.shopping_bag_outlined,
                size: context.sp(64),
                color: AppColors.navyBlue,
              ),
            ),

          // Discount Tag
          if (discountPercent > 0)
            Positioned(
              bottom: context.hp(2.2),
              left: context.wp(5),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.wp(2.6),
                  vertical: context.hp(0.45),
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "-${discountPercent.round()}% OFF",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.sp(10.5),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

          // Minimal Dots Slider Indicator
          if (images.length > 1)
            Positioned(
              bottom: context.hp(2.4),
              right: context.wp(5),
              child: Row(
                children: List.generate(images.length, (index) {
                  final isSelected = currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(left: context.wp(1.0)),
                    width: isSelected ? context.wp(5.5) : context.wp(1.6),
                    height: 5,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.navyBlue
                          : const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

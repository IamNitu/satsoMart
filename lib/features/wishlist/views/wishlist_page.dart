import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  final List<Map<String, dynamic>> _wishlistItems = const [
    {
      "name": "Apple Watch Series Ultra Titanium",
      "price": "\$199.00",
      "oldPrice": "\$249.00",
      "rating": "4.9",
      "icon": Icons.watch_rounded,
      "category": "Electronics",
    },
    {
      "name": "Ergonomic Lumbar Office Chair",
      "price": "\$149.00",
      "oldPrice": "\$219.00",
      "rating": "4.7",
      "icon": Icons.chair_rounded,
      "category": "Home",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "My Wishlist",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.navyBlue,
            fontSize: context.sp(20),
          ),
        ),
      ),
      body: _wishlistItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: context.sp(64),
                    color: AppColors.textLight,
                  ),
                  SizedBox(height: context.hp(2)),
                  Text(
                    "Your wishlist is empty",
                    style: TextStyle(
                      fontSize: context.sp(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: context.hp(0.8)),
                  Text(
                    "Save items you love to find them easily later!",
                    style: TextStyle(
                      fontSize: context.sp(13),
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.only(
                left: context.wp(5),
                right: context.wp(5),
                bottom: context.hp(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.hp(1)),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _wishlistItems.length,
                    separatorBuilder: (context, index) => SizedBox(height: context.hp(1.5)),
                    itemBuilder: (context, index) {
                      final item = _wishlistItems[index];
                      return Container(
                        padding: EdgeInsets.all(context.wp(3.5)),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navyBlue.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: context.wp(18),
                              height: context.wp(18),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item["icon"] as IconData,
                                size: context.sp(28),
                                color: AppColors.navyBlue,
                              ),
                            ),
                            SizedBox(width: context.wp(3)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: context.sp(13.5),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  SizedBox(height: context.hp(0.4)),
                                  Row(
                                    children: [
                                      Text(
                                        item["price"] as String,
                                        style: TextStyle(
                                          fontSize: context.sp(14.5),
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.accentBlue,
                                        ),
                                      ),
                                      SizedBox(width: context.wp(2)),
                                      Text(
                                        item["oldPrice"] as String,
                                        style: TextStyle(
                                          fontSize: context.sp(11),
                                          color: AppColors.textLight,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.shopping_bag_outlined,
                                color: AppColors.accentBlue,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Moved ${item['name']} to Cart!"),
                                    backgroundColor: AppColors.navyBlue,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

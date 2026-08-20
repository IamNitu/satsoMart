import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      "name": "Sony WH-1000XM5 Headphones",
      "price": 129.99,
      "quantity": 1,
      "icon": Icons.headphones_rounded,
      "color": "Silver Platinum",
    },
    {
      "name": "Nike Air Modern Retro Sneaker",
      "price": 79.50,
      "quantity": 2,
      "icon": Icons.roller_skating_rounded,
      "color": "Size 42 - White/Blue",
    },
  ];

  double get _subtotal => _cartItems.fold(
        0,
        (sum, item) => sum + ((item["price"] as double) * (item["quantity"] as int)),
      );
  double get _deliveryFee => _cartItems.isEmpty ? 0.0 : 10.0;
  double get _total => _subtotal + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.navyBlue,
            fontSize: context.sp(20),
          ),
        ),
        actions: [
          if (_cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                setState(() {
                  _cartItems.clear();
                });
              },
              child: Text(
                "Clear",
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  fontSize: context.sp(13),
                ),
              ),
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: context.sp(64),
                    color: AppColors.textLight,
                  ),
                  SizedBox(height: context.hp(2)),
                  Text(
                    "Your cart is empty",
                    style: TextStyle(
                      fontSize: context.sp(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: context.hp(0.8)),
                  Text(
                    "Explore products and add them to your cart!",
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
                  // Cart items list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _cartItems.length,
                    separatorBuilder: (context, index) => SizedBox(height: context.hp(1.5)),
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
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
                            // Product Icon Box
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
                            // Title & Price
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
                                  SizedBox(height: context.hp(0.3)),
                                  Text(
                                    item["color"] as String,
                                    style: TextStyle(
                                      fontSize: context.sp(11),
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  SizedBox(height: context.hp(0.8)),
                                  Text(
                                    "\$${(item['price'] as double).toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: context.sp(14.5),
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.accentBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity Controls
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if ((item["quantity"] as int) > 1) {
                                        item["quantity"] = (item["quantity"] as int) - 1;
                                      } else {
                                        _cartItems.removeAt(index);
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(context.wp(1.2)),
                                    decoration: BoxDecoration(
                                      color: AppColors.backgroundWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: AppColors.borderLight),
                                    ),
                                    child: Icon(
                                      Icons.remove_rounded,
                                      size: context.sp(14),
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: context.wp(2.5)),
                                  child: Text(
                                    "${item['quantity']}",
                                    style: TextStyle(
                                      fontSize: context.sp(13.5),
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      item["quantity"] = (item["quantity"] as int) + 1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(context.wp(1.2)),
                                    decoration: BoxDecoration(
                                      color: AppColors.navyBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: context.sp(14),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: context.hp(3)),

                  // Order Summary Card
                  Container(
                    padding: EdgeInsets.all(context.wp(4.5)),
                    decoration: BoxDecoration(
                      color: AppColors.cardWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: context.sp(15),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: context.hp(1.5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal", style: TextStyle(color: AppColors.textGrey, fontSize: context.sp(13))),
                            Text("\$${_subtotal.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: context.sp(13))),
                          ],
                        ),
                        SizedBox(height: context.hp(0.8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Fee", style: TextStyle(color: AppColors.textGrey, fontSize: context.sp(13))),
                            Text("\$${_deliveryFee.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark, fontSize: context.sp(13))),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: context.hp(1.2)),
                          child: const Divider(color: AppColors.borderLight),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark, fontSize: context.sp(15))),
                            Text(
                              "\$${_total.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: AppColors.accentBlue,
                                fontSize: context.sp(17),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: context.hp(3)),

                  // Checkout Button
                  AdaptiveButton(
                    text: "Proceed to Checkout",
                    icon: Icons.lock_outline_rounded,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Proceeding to secure checkout..."),
                          backgroundColor: AppColors.navyBlue,
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

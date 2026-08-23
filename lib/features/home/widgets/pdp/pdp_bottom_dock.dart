import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class PdpBottomDock extends StatelessWidget {
  final String productName;
  final int quantity;
  final bool isOutOfStock;
  final VoidCallback onAddToCart;
  final VoidCallback onBuyNow;

  const PdpBottomDock({
    super.key,
    required this.productName,
    required this.quantity,
    required this.isOutOfStock,
    required this.onAddToCart,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.wp(4.5),
          vertical: context.hp(1.4),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Outlined Add to Cart (Accent Blue)
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: context.hp(5.2),
                  child: OutlinedButton.icon(
                    onPressed: isOutOfStock ? null : onAddToCart,
                    icon: Icon(
                      Icons.add_shopping_cart_rounded,
                      size: 16,
                      color: isOutOfStock ? AppColors.textLight : AppColors.accentBlue,
                    ),
                    label: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: context.sp(12.5),
                        fontWeight: FontWeight.w800,
                        color: isOutOfStock ? AppColors.textLight : AppColors.accentBlue,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isOutOfStock
                            ? const Color(0xFFCBD5E1)
                            : AppColors.accentBlue,
                        width: 1.6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: context.wp(2.8)),

              // Elevated Buy Now (Solid Accent Blue)
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: context.hp(5.2),
                  child: ElevatedButton.icon(
                    onPressed: isOutOfStock ? null : onBuyNow,
                    icon: const Icon(
                      Icons.bolt_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(
                      isOutOfStock ? "Out of Stock" : "Buy Now",
                      style: TextStyle(
                        fontSize: context.sp(13),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.3,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isOutOfStock ? AppColors.textLight : AppColors.accentBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

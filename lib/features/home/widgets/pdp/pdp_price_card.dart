import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';

class PdpPriceCard extends StatelessWidget {
  final double effectivePrice;
  final double originalPrice;
  final double? discountPrice;
  final int quantity;
  final int stock;
  final ValueChanged<int> onQuantityChanged;

  const PdpPriceCard({
    super.key,
    required this.effectivePrice,
    required this.originalPrice,
    this.discountPrice,
    required this.quantity,
    required this.stock,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(4),
        vertical: context.hp(1.2),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL PRICE",
                style: TextStyle(
                  fontSize: context.sp(9.5),
                  fontWeight: FontWeight.w800,
                  color: AppColors.textGrey,
                  letterSpacing: 0.8,
                ),
              ),
              SizedBox(height: context.hp(0.2)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "\$${(effectivePrice * quantity).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: context.sp(22),
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (discountPrice != null && originalPrice > discountPrice!) ...[
                    SizedBox(width: context.wp(2)),
                    Text(
                      "\$${(originalPrice * quantity).toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: context.sp(12.5),
                        color: AppColors.textLight,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Quantity Selector Pill
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.wp(1.2),
              vertical: context.hp(0.4),
            ),
            child: Row(
              children: [
                _buildQuantityBtn(
                  icon: Icons.remove_rounded,
                  onTap: quantity > 1
                      ? () => onQuantityChanged(quantity - 1)
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.wp(2.8),
                  ),
                  child: Text(
                    "$quantity",
                    style: TextStyle(
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.w900,
                      color: AppColors.navyBlue,
                    ),
                  ),
                ),
                _buildQuantityBtn(
                  icon: Icons.add_rounded,
                  onTap: quantity < stock
                      ? () => onQuantityChanged(quantity + 1)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 15,
          color: isEnabled ? AppColors.navyBlue : AppColors.textLight,
        ),
      ),
    );
  }
}

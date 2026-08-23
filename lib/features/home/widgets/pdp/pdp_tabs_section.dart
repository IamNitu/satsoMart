import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';

class PdpTabsSection extends StatefulWidget {
  final Product product;

  const PdpTabsSection({super.key, required this.product});

  @override
  State<PdpTabsSection> createState() => _PdpTabsSectionState();
}

class _PdpTabsSectionState extends State<PdpTabsSection> {
  int _selectedTabIndex = 0; // 0: Description, 1: Specifications

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Switcher Pill
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildTabButton(0, "Description"),
              _buildTabButton(1, "Specifications"),
            ],
          ),
        ),

        SizedBox(height: context.hp(1.2)),

        // Tab Content
        _buildContent(context),
      ],
    );
  }

  Widget _buildTabButton(int index, String title) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTabIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: context.hp(0.9)),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: context.sp(12),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected ? AppColors.navyBlue : AppColors.textGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_selectedTabIndex == 0) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(context.wp(4)),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.product.shortDescription != null &&
                widget.product.shortDescription!.isNotEmpty) ...[
              Text(
                widget.product.shortDescription!,
                style: TextStyle(
                  fontSize: context.sp(12.5),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  height: 1.35,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.hp(0.8)),
                child: const Divider(height: 1, color: Color(0xFFE2E8F0)),
              ),
            ],
            Text(
              widget.product.description.isNotEmpty
                  ? widget.product.description
                  : "No detailed description provided for this product.",
              style: TextStyle(
                fontSize: context.sp(12),
                color: AppColors.textGrey,
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(context.wp(4)),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Column(
          children: [
            _buildSpecRow("Brand", widget.product.brand ?? "SastoMart Verified"),
            _buildSpecRow("Category", widget.product.category?.name ?? "General"),
            if (widget.product.sku != null)
              _buildSpecRow("SKU", widget.product.sku!),
            _buildSpecRow("Stock Available", "${widget.product.stock} units"),
            if (widget.product.tags.isNotEmpty)
              _buildSpecRow("Tags", widget.product.tags.join(", ")),
          ],
        ),
      );
    }
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

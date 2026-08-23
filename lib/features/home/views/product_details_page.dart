import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_bottom_dock.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_floating_top_bar.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_hero_gallery.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_price_card.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_reviews_card.dart';
import 'package:sasto_mart/features/home/widgets/pdp/pdp_tabs_section.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentImageIndex = 0;
  final PageController _pageController = PageController();
  int _quantity = 1;
  bool _isFavorite = false;

  List<String> get _allImages {
    final List<String> images = [];
    if (widget.product.featuredImage != null &&
        widget.product.featuredImage!.isNotEmpty) {
      images.add(widget.product.featuredImage!);
    }
    if (widget.product.images != null && widget.product.images!.isNotEmpty) {
      for (final img in widget.product.images!) {
        if (!images.contains(img)) {
          images.add(img);
        }
      }
    }
    return images;
  }

  double get _discountPercent {
    if (widget.product.discountPrice != null &&
        widget.product.price > widget.product.discountPrice!) {
      return ((widget.product.price - widget.product.discountPrice!) /
              widget.product.price) *
          100;
    }
    return 0;
  }

  double get _effectivePrice =>
      widget.product.discountPrice ?? widget.product.price;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _allImages;
    final isOutOfStock = widget.product.stock <= 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Clean soft porcelain backdrop
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: context.hp(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Edge-to-Edge Hero Image Section
                PdpHeroGallery(
                  images: images,
                  pageController: _pageController,
                  currentIndex: _currentImageIndex,
                  discountPercent: _discountPercent,
                  onPageChanged: (index) =>
                      setState(() => _currentImageIndex = index),
                ),

                // 2. Main Product Content Sheet (Luxury Rounded Top)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(26)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.wp(4.5),
                    vertical: context.hp(2.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag & Stock Status Row
                      _buildHeaderMetaRow(context, isOutOfStock),

                      SizedBox(height: context.hp(0.8)),

                      // Editorial Title
                      Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: context.sp(19),
                          fontWeight: FontWeight.w900,
                          color: AppColors.textDark,
                          height: 1.25,
                          letterSpacing: -0.4,
                        ),
                      ),

                      SizedBox(height: context.hp(1.2)),

                      // Rating & Social Proof Strip
                      _buildSocialProofStrip(context),

                      SizedBox(height: context.hp(1.6)),

                      // Price & Quantity Showcase Card
                      PdpPriceCard(
                        effectivePrice: _effectivePrice,
                        originalPrice: widget.product.price,
                        discountPrice: widget.product.discountPrice,
                        quantity: _quantity,
                        stock: widget.product.stock,
                        onQuantityChanged: (q) =>
                            setState(() => _quantity = q),
                      ),

                      SizedBox(height: context.hp(1.8)),

                      // Segmented Tab Switcher (Description & Specifications)
                      PdpTabsSection(product: widget.product),

                      SizedBox(height: context.hp(2.0)),

                      // ⭐ Customer Reviews Card with Dynamic Count Progress Bars
                      PdpReviewsCard(ratings: widget.product.ratings),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Floating Glassmorphic Top Bar (Back, Share, Wishlist)
          PdpFloatingTopBar(
            isFavorite: _isFavorite,
            onBack: () => Navigator.pop(context),
            onShare: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Product link copied!"),
                  backgroundColor: AppColors.navyBlue,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                ),
              );
            },
            onFavoriteToggle: () {
              setState(() => _isFavorite = !_isFavorite);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isFavorite
                        ? "Saved to Wishlist"
                        : "Removed from Wishlist",
                  ),
                  backgroundColor: AppColors.navyBlue,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),

          // 4. Floating Bottom Checkout Dock
          PdpBottomDock(
            productName: widget.product.name,
            quantity: _quantity,
            isOutOfStock: isOutOfStock,
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added $_quantity × ${widget.product.name} to Cart!",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: AppColors.navyBlue,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            onBuyNow: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Proceeding to checkout for ${widget.product.name}...",
                  ),
                  backgroundColor: AppColors.navyBlue,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderMetaRow(BuildContext context, bool isOutOfStock) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (widget.product.brand?.isNotEmpty == true
                  ? widget.product.brand!
                  : (widget.product.category?.name ?? "SASTOMART"))
              .toUpperCase(),
          style: TextStyle(
            color: AppColors.accentBlue,
            fontSize: context.sp(11),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.3,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.wp(2.5),
            vertical: context.hp(0.35),
          ),
          decoration: BoxDecoration(
            color: isOutOfStock
                ? const Color(0xFFFEE2E2)
                : const Color(0xFFDCFCE7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOutOfStock ? AppColors.error : AppColors.success,
                ),
              ),
              SizedBox(width: context.wp(1.2)),
              Text(
                isOutOfStock
                    ? "Out of Stock"
                    : "In Stock (${widget.product.stock})",
                style: TextStyle(
                  color: isOutOfStock
                      ? AppColors.error
                      : const Color(0xFF15803D),
                  fontSize: context.sp(10.5),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialProofStrip(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.wp(3),
        vertical: context.hp(0.7),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star_rounded,
            color: Color(0xFFF59E0B),
            size: 17,
          ),
          SizedBox(width: context.wp(1)),
          Text(
            widget.product.ratings.average.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.sp(12.5),
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(width: context.wp(1.2)),
          Text(
            "(${widget.product.ratings.count} reviews)",
            style: TextStyle(
              fontSize: context.sp(11),
              color: AppColors.textGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            width: 1,
            height: 14,
            color: const Color(0xFFCBD5E1),
          ),
          const Spacer(),
          const Icon(
            Icons.verified_rounded,
            size: 15,
            color: AppColors.accentBlue,
          ),
          SizedBox(width: context.wp(1)),
          Text(
            "100% Genuine",
            style: TextStyle(
              fontSize: context.sp(11),
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

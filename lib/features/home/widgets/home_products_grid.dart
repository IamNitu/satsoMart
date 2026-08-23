import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/core/api/api_endpoints.dart';
import 'package:sasto_mart/features/cart/bloc/cart_bloc.dart';
import 'package:sasto_mart/features/home/api/products_api.dart';
import 'package:sasto_mart/features/home/models/product_model.dart';
import 'package:sasto_mart/features/home/views/product_details_page.dart';

class HomeProductsGrid extends StatefulWidget {
  const HomeProductsGrid({super.key});

  @override
  State<HomeProductsGrid> createState() => _HomeProductsGridState();
}

class _HomeProductsGridState extends State<HomeProductsGrid> {
  final ProductsApi _productsApi =ProductsApi();
  List<Product> _products =[];
  bool _isLoading =true;
  String? _error;
  final Set<int> _favoriteIndices = {};

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async{
    setState(() {
      _isLoading =true;
      _error =null;
    });
    try{
      final response = await _productsApi.getProducts();
      setState(() {
        _products = response.products;
        _isLoading =false;
      });
    }catch(e){
      _error =e.toString();
      _isLoading=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AdaptiveSize.horizontalPadding(context, percent: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Deals",
                    style: TextStyle(
                      fontSize: context.sp(17),
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: context.hp(0.2)),
                  Text(
                    "Handpicked discounts for you",
                    style: TextStyle(
                      fontSize: context.sp(11.5),
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: context.hp(0.2)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: context.sp(12.5),
                          fontWeight: FontWeight.w700,
                          color: AppColors.accentBlue,
                        ),
                      ),
                      SizedBox(width: context.wp(0.8)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: context.sp(11),
                        color: AppColors.accentBlue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.hp(1.6)),
        Padding(
          padding: AdaptiveSize.horizontalPadding(context, percent: 3),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth < 600 ? 2 : 3;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: context.wp(2.0),
                  mainAxisSpacing: context.hp(1.0),
                  childAspectRatio: context.isSmallScreen ? 0.68 : 0.70,
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final isFavorite = _favoriteIndices.contains(index);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.borderLight.withValues(alpha: 0.8),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.navyBlue.withValues(alpha: 0.05),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: product.featuredImage != null && product.featuredImage!.isNotEmpty
                                        ? Image.network(
                                            ApiEndpoints.imageUrl(product.featuredImage),
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                            height: double.infinity,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(
                                                child: SizedBox(
                                                  width: context.wp(5),
                                                  height: context.wp(5),
                                                  child: const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppColors.accentBlue,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(
                                                Icons.image_not_supported_outlined,
                                                size: context.sp(36),
                                                color: AppColors.textLight,
                                              );
                                            },
                                          )
                                        : Icon(
                                            Icons.shopping_bag_outlined,
                                            size: context.sp(36),
                                            color: AppColors.navyBlue,
                                          ),
                                  ),
                                ),
                                if (product.discountPrice != null)
                                  Positioned(
                                    top: context.hp(1.0),
                                    left: context.wp(2.5),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.wp(2.2),
                                        vertical: context.hp(0.4),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.accentBlue,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.accentBlue.withValues(alpha: 0.3),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        product.discountPrice.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: context.sp(10),
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                Positioned(
                                  top: context.hp(0.8),
                                  right: context.wp(2.2),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isFavorite) {
                                          _favoriteIndices.remove(index);
                                        } else {
                                          _favoriteIndices.add(index);
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(context.wp(1.8)),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.92),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.08),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite_rounded
                                            : Icons.favorite_border_rounded,
                                        size: context.sp(16),
                                        color: isFavorite
                                            ? Colors.redAccent
                                            : AppColors.textGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.all(context.wp(3.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            size: context.sp(14),
                                            color: const Color(0xFFF59E0B),
                                          ),
                                          SizedBox(width: context.wp(0.8)),
                                          Text(
                                            product.ratings.toString(),
                                            style: TextStyle(
                                              fontSize: context.sp(11),
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          // if (product["reviews"] != null) ...[
                                          //   SizedBox(width: context.wp(0.8)),
                                          //   Text(
                                          //     product["reviews"] as String,
                                          //     style: TextStyle(
                                          //       fontSize: context.sp(10),
                                          //       color: AppColors.textLight,
                                          //       fontWeight: FontWeight.w400,
                                          //     ),
                                          //   ),
                                          // ],
                                        ],
                                      ),
                                      SizedBox(height: context.hp(0.4)),
                                      Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: context.sp(12.5),
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textDark,
                                          height: 1.25,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (product.price != null)
                                            Text(
                                              product.price.toString(),
                                              style: TextStyle(
                                                fontSize: context.sp(10.5),
                                                color: AppColors.textLight,
                                                decoration: TextDecoration.lineThrough,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          Text(
                                            product.discountPrice.toString(),
                                            style: TextStyle(
                                              fontSize: context.sp(14.5),
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.accentBlue,
                                              letterSpacing: -0.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Material(
                                        color: AppColors.navyBlue,
                                        borderRadius: BorderRadius.circular(10),
                                        child: InkWell(
                                          onTap: () {
                                            if(product.stock <=0){
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text("Sorry, this item is out of stock!"),
                                                backgroundColor: AppColors.error,
                                                behavior: SnackBarBehavior.floating,
                                                duration: Duration(seconds: 1),),
                                              );
                                              return;
                                            }context.read<CartBloc>().add(AddToCart(product,quantity: 1));
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Added ${product.name} to cart!",
                                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                                ),
                                                backgroundColor: AppColors.navyBlue,
                                                behavior: SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                duration: const Duration(seconds: 2),
                                              ),
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            padding: EdgeInsets.all(context.wp(2.0)),
                                            child: Icon(
                                              Icons.add_rounded,
                                              size: context.sp(16),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    )
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

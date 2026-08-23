import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/home/views/main_navigation_shell.dart';
import 'package:sasto_mart/features/home/widgets/home_app_bar.dart';
import 'package:sasto_mart/features/home/widgets/home_search_bar.dart';
import 'package:sasto_mart/features/home/widgets/home_promo_banner.dart';
import 'package:sasto_mart/features/home/widgets/home_products_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigationShell();
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  // final List<Map<String, dynamic>> _categories = const [
  //   {"name": "All", "icon": Icons.grid_view_rounded},
  //   {"name": "Electronics", "icon": Icons.devices_rounded},
  //   {"name": "Fashion", "icon": Icons.checkroom_rounded},
  //   {"name": "Home", "icon": Icons.chair_rounded},
  //   {"name": "Shoes", "icon": Icons.snowshoeing_rounded},
  //   {"name": "Groceries", "icon": Icons.fastfood_rounded},
  // ];

  // final List<Map<String, dynamic>> _featuredProducts = const [
  //   {
  //     "name": "Sony WH-1000XM5 Wireless Headphones",
  //     "price": "\$129.99",
  //     "oldPrice": "\$189.99",
  //     "discount": "-30%",
  //     "rating": "4.8",
  //     "reviews": "(1.2k)",
  //     "category": "Electronics",
  //     "icon": Icons.headphones_rounded,
  //   },
  //   {
  //     "name": "Nike Air Modern Retro Sneaker",
  //     "price": "\$79.50",
  //     "oldPrice": "\$110.00",
  //     "discount": "-25%",
  //     "rating": "4.6",
  //     "reviews": "(850)",
  //     "category": "Fashion",
  //     "icon": Icons.roller_skating_rounded,
  //   },
  //   {
  //     "name": "Apple Watch Series Ultra Titanium",
  //     "price": "\$199.00",
  //     "oldPrice": "\$249.00",
  //     "discount": "-20%",
  //     "rating": "4.9",
  //     "reviews": "(2.4k)",
  //     "category": "Electronics",
  //     "icon": Icons.watch_rounded,
  //   },
  //   {
  //     "name": "Ergonomic Lumbar Office Chair",
  //     "price": "\$149.00",
  //     "oldPrice": "\$219.00",
  //     "discount": "-32%",
  //     "rating": "4.7",
  //     "reviews": "(640)",
  //     "category": "Home",
  //     "icon": Icons.chair_rounded,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: context.hp(12), // Space for floating bottom nav
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.hp(1.2)),

              // Search Bar
              const HomeSearchBar(),

              SizedBox(height: context.hp(2.4)),

              // Promotional Banner
              const HomePromoBanner(),

              SizedBox(height: context.hp(2.6)),

              // Horizontal Category Chips Section
              // HomeCategoriesSection(
              //   categories: _categories,
              //   selectedIndex: _selectedCategoryIndex,
              //   onCategorySelected: (index) {
              //     setState(() {
              //       _selectedCategoryIndex = index;
              //     });
              //   },
              // ),

              SizedBox(height: context.hp(2.8)),

              // Responsive Products Grid Section
              HomeProductsGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
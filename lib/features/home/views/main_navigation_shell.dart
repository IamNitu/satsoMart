import 'package:flutter/material.dart';
import 'package:sasto_mart/core/adaptive/adaptive.dart';
import 'package:sasto_mart/features/home/views/home_page.dart';
import 'package:sasto_mart/features/home/widgets/home_bottom_nav_bar.dart';
import 'package:sasto_mart/features/cart/views/cart_page.dart';
import 'package:sasto_mart/features/wishlist/views/wishlist_page.dart';
import 'package:sasto_mart/features/profile/views/profile_page.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePageContent(),
    CartPage(),
    WishlistPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      extendBody: true, // Allows floating navbar to sit smoothly above content
      bottomNavigationBar: HomeBottomNavBar(
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/core/navigation/bottom_navigation.dart';
import 'package:shopping_hut/feature/cart/presentation/ui/cart.dart';
import 'package:shopping_hut/feature/home/presentation/ui/home.dart';
import 'package:shopping_hut/feature/products/data/datasources/product_local_data_source.dart';
import 'package:shopping_hut/feature/products/data/repositories/product_repository_impl.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_bloc.dart';
import 'package:shopping_hut/feature/products/presentation/ui/products_page.dart';
import 'package:shopping_hut/feature/settings/presentation/ui/settings_page.dart';
import 'package:shopping_hut/feature/wishlist/presentation/ui/wishlist.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const Home(),
    BlocProvider(
      create: (context) => ProductBloc(
        repository: ProductRepositoryImpl(
          dataSource: ProductLocalDataSource(),
        ),
      ),
      child: const ProductsPage(),
    ),
    const Wishlist(),
    const Cart(),
    const SettingsPage(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
} 
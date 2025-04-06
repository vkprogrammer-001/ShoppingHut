import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/cart/presentation/ui/cart.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';
import 'package:shopping_hut/feature/home/presentation/bloc/home_bloc.dart';
import 'package:shopping_hut/feature/home/presentation/ui/product_tile_widgets.dart';
import 'package:shopping_hut/feature/settings/presentation/ui/settings_page.dart';
import 'package:shopping_hut/feature/wishlist/presentation/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  HomeBloc homeBloc = HomeBloc();
  String searchQuery = '';
  List<ProductDataModel> filteredProducts = [];
  String selectedCategory = 'All';
  List<String> categories = ['All'];

  void filterProducts(List<ProductDataModel> products, String query, String category) {
    setState(() {
      List<ProductDataModel> tempList = products;
      
      // Apply category filter first
      if (category != 'All') {
        tempList = tempList.where((product) => 
          product.category.toLowerCase() == category.toLowerCase()
        ).toList();
      }
      
      // Then apply search query
      if (query.isNotEmpty) {
        tempList = tempList.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()) ||
          product.description.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
      
      filteredProducts = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPage) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPage) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is ProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Carted')));
        } else if (state is ProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(2.0),
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/images/hut.png'),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Shopping Hut",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                ],
              ),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            
            // Initialize filtered products if empty
            if (filteredProducts.isEmpty) {
              filteredProducts = successState.products;
            }
            
            // Update categories if needed
            if (categories.length == 1) {
              Set<String> uniqueCategories = {'All'};
              for (var product in successState.products) {
                uniqueCategories.add(product.category);
              }
              categories = uniqueCategories.toList();
            }
            
            return Scaffold(
              appBar: AppBar(
                title: const Text("Shopping Hut"),
                backgroundColor: Colors.teal,
                elevation: 0,
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeWishlistEvent());
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartEvent());
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: Column(
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        filterProducts(successState.products, value, selectedCategory);
                      },
                    ),
                  ),
                  
                  // Categories
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: ChoiceChip(
                            label: Text(categories[index]),
                            selected: selectedCategory == categories[index],
                            selectedColor: Colors.teal.withOpacity(0.3),
                            labelStyle: TextStyle(
                              color: selectedCategory == categories[index] 
                                  ? Colors.teal 
                                  : Colors.black,
                              fontWeight: selectedCategory == categories[index]
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            onSelected: (selected) {
                              if (selected) {
                                setState(() {
                                  selectedCategory = categories[index];
                                  filterProducts(
                                    successState.products, 
                                    searchQuery, 
                                    selectedCategory
                                  );
                                });
                              }
                            },
                          ),
                        );
                      }
                    ),
                  ),
                  
                  // Product grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: filteredProducts.isEmpty
                          ? const Center(
                              child: Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                return ProductTileWidget(
                                  homeBloc: homeBloc,
                                  productDataModel: filteredProducts[index],
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            );
          case HomeErrorState:
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Error Loading Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        homeBloc.add(HomeInitialEvent());
                      },
                      child: const Text("Try Again"),
                    ),
                  ],
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

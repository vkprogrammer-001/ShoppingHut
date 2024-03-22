import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/cart/ui/cart.dart';
import 'package:shopping_hut/feature/home/bloc/home_bloc.dart';
import 'package:shopping_hut/feature/home/ui/product_tile_widgets.dart';
import 'package:shopping_hut/feature/wishlist/ui/wishlist.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPage) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>  const Cart()));
        } else if (state is HomeNavigateToWishlistPage) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Wishlist()));
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
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(2.0),
                  child: Image.asset('assets/images/hut.png')),
                const SizedBox(height: 4),
                const CircularProgressIndicator(),
              ],
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Vipin App"),
                backgroundColor: Colors.teal,
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                        homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Text("Error"),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

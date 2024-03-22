import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/Data/wishlist_items.dart';
import 'package:shopping_hut/Data/cart_items.dart';
import 'package:shopping_hut/Data/grocery_data.dart';
import 'package:shopping_hut/feature/home/model/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductCartEvent>(homeProductCartEvent);
    on<HomeProductWishlistEvent>(homeProductWishlistEvent);
    on<HomeCartEvent>(homeCartEvent);
    on<HomeWishlistEvent>(homeWishlistEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryData.sampleGroceryProducts
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                imageURL: e['imageURL']))
            .toList()));
  }

  FutureOr<void> homeProductCartEvent(
      HomeProductCartEvent event, Emitter<HomeState> emit) {
    print("Product Cart Clicked");
    cartItems.add(event.clickedProduct);
    emit(ProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductWishlistEvent(
      HomeProductWishlistEvent event, Emitter<HomeState> emit) {
    print("Product Wishlist Clicked");
    wishlistItems.add(event.clickedProduct);
    emit(ProductItemCartedActionState());
  }

  FutureOr<void> homeCartEvent(HomeCartEvent event, Emitter<HomeState> emit) {
    print("Cart Clicked");
    emit(HomeNavigateToCartPage());
  }

  FutureOr<void> homeWishlistEvent(
      HomeWishlistEvent event, Emitter<HomeState> emit) {
    print("Wishlist Clicked");
    emit(HomeNavigateToWishlistPage());
  }
}

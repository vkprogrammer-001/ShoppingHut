import 'dart:async';

// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/wishlist/data/datasources/wishlist_items.dart';
import 'package:shopping_hut/feature/cart/data/datasources/cart_items.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';

// import '../../data/datasources/grocery_remote_data_source.dart';

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
    final Dio dio = Dio();
    const baseUrl = 'https://fakestoreapi.com/products';
    List<ProductDataModel> productInfo = [];
    try {
      Response productData = await dio.get(baseUrl);
      print("user data: $productData");
      for (var item in productData.data) {
        ProductDataModel json = ProductDataModel.fromJson(item);
        productInfo.add(json);
      }
      print("user info: $productInfo");
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedSuccessState(products: productInfo));
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

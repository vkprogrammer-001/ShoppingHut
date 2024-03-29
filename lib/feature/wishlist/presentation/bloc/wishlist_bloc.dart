import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping_hut/feature/wishlist/data/datasources/wishlist_items.dart';
import 'package:shopping_hut/feature/cart/data/datasources/cart_items.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';


part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemovedFromWishlistEvent>(wishlistRemovedFromWishlistEvent);
    on<WishlistProductCartEvent>(wishlistProductCartEvent);
  }

  FutureOr<void> wishlistInitialEvent(WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemovedFromWishlistEvent(WishlistRemovedFromWishlistEvent event, Emitter<WishlistState>
 emit) {
  wishlistItems.remove(event.productDataModel);
  emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistProductCartEvent(WishlistProductCartEvent event, Emitter<WishlistState> emit) {
    print("Wishlist Product Cart Clicked");
    cartItems.add(event.clickedProduct);
    emit(WishlistProductItemCartedActionState());
  }
}

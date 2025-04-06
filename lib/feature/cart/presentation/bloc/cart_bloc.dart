import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/cart/data/datasources/cart_items.dart';
import 'package:shopping_hut/feature/cart/presentation/bloc/cart_state.dart';

part 'cart_event.dart';


class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CartIncrementQuantityEvent>(cartIncrementQuantityEvent);
    on<CartDecrementQuantityEvent>(cartDecrementQuantityEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    removeFromCart(event.productId);
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartIncrementQuantityEvent(CartIncrementQuantityEvent event, Emitter<CartState> emit) {
    incrementQuantity(event.productId);
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartDecrementQuantityEvent(CartDecrementQuantityEvent event, Emitter<CartState> emit) {
    decrementQuantity(event.productId);
    emit(CartSuccessState(cartItems: cartItems));
  }
}

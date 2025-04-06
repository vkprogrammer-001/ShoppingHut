import 'package:flutter/material.dart';
import 'package:shopping_hut/feature/cart/data/model/cart_item_model.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<CartItem> cartItems;
  final double totalPrice;

  CartSuccessState({required this.cartItems})
      : totalPrice = cartItems.fold(
            0, (sum, item) => sum + (item.product.price * item.quantity));
}

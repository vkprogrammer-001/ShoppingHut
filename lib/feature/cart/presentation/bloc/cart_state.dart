import 'package:flutter/material.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';

@immutable
abstract class CartState {}

abstract class CartActionState  extends CartState{}

class CartInitial extends CartState {}

class CartSuccessState extends CartState{
  final List<ProductDataModel> cartItems;

  CartSuccessState({required this.cartItems});
}

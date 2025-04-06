part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends  CartEvent{}

class CartRemoveFromCartEvent extends  CartEvent{
  final int productId;
  CartRemoveFromCartEvent({required this.productId});
  
}

class CartIncrementQuantityEvent extends CartEvent {
  final int productId;
  CartIncrementQuantityEvent({required this.productId});
}

class CartDecrementQuantityEvent extends CartEvent {
  final int productId;
  CartDecrementQuantityEvent({required this.productId});
}

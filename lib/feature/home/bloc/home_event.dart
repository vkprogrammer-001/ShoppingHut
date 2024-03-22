part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeProductCartEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductCartEvent({required this.clickedProduct});
}

class HomeProductWishlistEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeProductWishlistEvent({required this.clickedProduct});
}

class HomeCartEvent extends HomeEvent {}

class HomeWishlistEvent extends HomeEvent {}

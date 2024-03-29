part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemovedFromWishlistEvent extends WishlistEvent {
  final ProductDataModel productDataModel;
  WishlistRemovedFromWishlistEvent({required this.productDataModel});
}

class WishlistProductCartEvent extends WishlistEvent{
  final ProductDataModel clickedProduct;
  WishlistProductCartEvent({required this.clickedProduct});
}

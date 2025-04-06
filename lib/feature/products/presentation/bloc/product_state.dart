import 'package:meta/meta.dart';
import 'package:shopping_hut/feature/products/data/model/product_model.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;

  ProductsLoaded(this.products);
}

class ProductLoaded extends ProductState {
  final ProductModel product;

  ProductLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
} 
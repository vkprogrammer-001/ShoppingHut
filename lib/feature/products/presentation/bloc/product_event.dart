import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent {}

class GetProducts extends ProductEvent {}

class GetProductById extends ProductEvent {
  final int id;

  GetProductById(this.id);
}

class GetProductsByCategory extends ProductEvent {
  final String category;

  GetProductsByCategory(this.category);
}

class GetProductsOnSale extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;

  SearchProducts(this.query);
} 
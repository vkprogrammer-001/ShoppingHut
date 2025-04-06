import 'package:shopping_hut/feature/products/data/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<ProductModel>> getProductsOnSale();
  Future<List<ProductModel>> searchProducts(String query);
} 
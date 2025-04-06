import 'package:shopping_hut/feature/products/data/datasources/product_data_source.dart';
import 'package:shopping_hut/feature/products/data/model/product_model.dart';
import 'package:shopping_hut/feature/products/data/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<List<ProductModel>> getProducts() async {
    return await dataSource.getProducts();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    return await dataSource.getProductById(id);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    return await dataSource.getProductsByCategory(category);
  }

  @override
  Future<List<ProductModel>> getProductsOnSale() async {
    return await dataSource.getProductsOnSale();
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    return await dataSource.searchProducts(query);
  }
} 
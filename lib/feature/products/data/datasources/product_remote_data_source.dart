import 'package:dio/dio.dart';
import 'package:shopping_hut/core/error/exceptions.dart';
import 'package:shopping_hut/feature/products/data/datasources/product_data_source.dart';
import 'package:shopping_hut/feature/products/data/model/product_model.dart';

class ProductRemoteDataSource implements ProductDataSource {
  final Dio dio;
  final String baseUrl;

  ProductRemoteDataSource({
    required this.dio,
    this.baseUrl = 'https://api.example.com',
  });

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('$baseUrl/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to load products');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('$baseUrl/products/$id');
      
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException('Failed to load product with id: $id');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {'category': category},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to load products for category: $category');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getProductsOnSale() async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {'onSale': true},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to load products on sale');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {'search': query},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data;
        return productsJson
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerException('Failed to search products');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
} 
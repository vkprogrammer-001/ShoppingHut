import 'package:shopping_hut/core/error/exceptions.dart';
import 'package:shopping_hut/feature/products/data/datasources/product_data_source.dart';
import 'package:shopping_hut/feature/products/data/model/product_model.dart';

class ProductLocalDataSource implements ProductDataSource {
  final List<ProductModel> _mockProducts = [
    ProductModel(
      id: 1,
      name: 'Classic White T-Shirt',
      description: 'A comfortable and versatile white t-shirt made from 100% cotton. Perfect for everyday wear and can be dressed up or down for any occasion.',
      price: 19.99,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Clothing',
      isOnSale: true,
      discountPercentage: 20,
    ),
    ProductModel(
      id: 2,
      name: 'Wireless Bluetooth Headphones',
      description: 'High-quality wireless headphones with noise cancellation, 24-hour battery life, and premium sound. Comfortable for all-day wear with cushioned ear cups.',
      price: 149.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Electronics',
    ),
    ProductModel(
      id: 3,
      name: 'Fitness Smartwatch',
      description: 'Track your workouts, heart rate, sleep, and more with this waterproof smartwatch. Features a color display, multiple sport modes, and up to 7 days of battery life.',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Electronics',
      isOnSale: true,
      discountPercentage: 15,
    ),
    ProductModel(
      id: 4,
      name: 'Leather Wallet',
      description: 'Genuine leather wallet with multiple card slots, bill compartment, and RFID blocking technology to protect your personal information.',
      price: 39.99,
      imageUrl: 'https://images.unsplash.com/photo-1517254797898-ee287a45f3a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Accessories',
    ),
    ProductModel(
      id: 5,
      name: 'Stainless Steel Water Bottle',
      description: 'Double-wall insulated water bottle that keeps drinks cold for 24 hours or hot for 12 hours. Made from high-quality stainless steel that is both durable and eco-friendly.',
      price: 24.99,
      imageUrl: 'https://images.unsplash.com/photo-1523362628745-0c100150b504?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Home & Kitchen',
    ),
    ProductModel(
      id: 6,
      name: 'Yoga Mat',
      description: 'Non-slip, eco-friendly yoga mat with excellent cushioning and support. Perfect for yoga, pilates, or any floor exercises at home or in the gym.',
      price: 29.99,
      imageUrl: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Sports',
      isOnSale: true,
      discountPercentage: 10,
    ),
    ProductModel(
      id: 7,
      name: 'Coffee Maker',
      description: 'Programmable coffee maker with 12-cup capacity, auto shut-off, and brew strength control. Wake up to freshly brewed coffee every morning.',
      price: 79.99,
      imageUrl: 'https://images.unsplash.com/photo-1544427920-c49ccfb85579?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Home & Kitchen',
    ),
    ProductModel(
      id: 8,
      name: 'Wireless Charging Pad',
      description: 'Fast wireless charging pad compatible with all Qi-enabled devices. Slim design with LED indicator and safety features to prevent overcharging.',
      price: 34.99,
      imageUrl: 'https://images.unsplash.com/photo-1591815302525-756a9bcc3425?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      category: 'Electronics',
      isOnSale: true,
      discountPercentage: 25,
    ),
  ];

  @override
  Future<List<ProductModel>> getProducts() async {
    return Future.delayed(
      const Duration(milliseconds: 800),
      () => _mockProducts,
    );
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () {
        final product = _mockProducts.firstWhere(
          (product) => product.id == id,
          orElse: () => throw ServerException('Product not found'),
        );
        return product;
      },
    );
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    return Future.delayed(
      const Duration(milliseconds: 800),
      () {
        final products = _mockProducts.where(
          (product) => product.category.toLowerCase() == category.toLowerCase(),
        ).toList();
        return products;
      },
    );
  }

  @override
  Future<List<ProductModel>> getProductsOnSale() async {
    return Future.delayed(
      const Duration(milliseconds: 800),
      () {
        final products = _mockProducts.where(
          (product) => product.isOnSale,
        ).toList();
        return products;
      },
    );
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    return Future.delayed(
      const Duration(milliseconds: 800),
      () {
        final products = _mockProducts.where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()),
        ).toList();
        return products;
      },
    );
  }
} 
class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isOnSale;
  final double? discountPercentage;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isOnSale = false,
    this.discountPercentage,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      isOnSale: json['isOnSale'] ?? false,
      discountPercentage: json['discountPercentage'] != null 
          ? (json['discountPercentage'] as num).toDouble() 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isOnSale': isOnSale,
      'discountPercentage': discountPercentage,
    };
  }
} 
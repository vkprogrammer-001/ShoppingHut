class ProductDataModel {
  int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  //Constructor for the product data model
  ProductDataModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});


  factory ProductDataModel.fromJson(Map<String, dynamic> data) {
    return ProductDataModel(
      id: data['id'],
      title: data['title'],
      price: double.parse(data['price'].toString()),
      description: data['description'],
      category: data['category'],
      image: data['image'],
      rating: data['rating']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title':title,
      'price':price,
      'description':description,
      'category':category,
      'image':image,
      'rating':rating
    };
  }
}

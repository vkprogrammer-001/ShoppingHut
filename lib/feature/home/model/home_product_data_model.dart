class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageURL;

  //Constructor for the product data model
  ProductDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.imageURL});
}

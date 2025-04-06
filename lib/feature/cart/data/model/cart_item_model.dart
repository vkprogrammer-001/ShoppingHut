import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';

class CartItem {
  final ProductDataModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
} 
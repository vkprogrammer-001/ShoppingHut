import 'package:shopping_hut/feature/cart/data/model/cart_item_model.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';

List<CartItem> cartItems = [];

// Helper functions for cart operations
void addToCart(ProductDataModel product) {
  // Check if product already exists in cart
  final existingItemIndex = cartItems.indexWhere((item) => item.product.id == product.id);
  
  if (existingItemIndex != -1) {
    // If product exists, increment quantity
    cartItems[existingItemIndex].incrementQuantity();
  } else {
    // If not, add as new item
    cartItems.add(CartItem(product: product));
  }
}

void removeFromCart(int productId) {
  cartItems.removeWhere((item) => item.product.id == productId);
}

void incrementQuantity(int productId) {
  final itemIndex = cartItems.indexWhere((item) => item.product.id == productId);
  if (itemIndex != -1) {
    cartItems[itemIndex].incrementQuantity();
  }
}

void decrementQuantity(int productId) {
  final itemIndex = cartItems.indexWhere((item) => item.product.id == productId);
  if (itemIndex != -1) {
    cartItems[itemIndex].decrementQuantity();
    // If quantity becomes 0, remove item (though this shouldn't happen with our implementation)
    if (cartItems[itemIndex].quantity <= 0) {
      removeFromCart(productId);
    }
  }
}

double getCartTotal() {
  return cartItems.fold(0, (total, item) => total + item.totalPrice);
}
import 'package:flutter/material.dart';
import 'package:shopping_hut/feature/cart/data/model/cart_item_model.dart';
import 'package:shopping_hut/feature/cart/presentation/bloc/cart_bloc.dart';

class CartTileWidget extends StatelessWidget {
  final CartItem cartItem;
  final CartBloc cartBloc;
  
  const CartTileWidget({
    super.key, 
    required this.cartItem, 
    required this.cartBloc
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(cartItem.product.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price information
                  Row(
                    children: [
                      Text(
                        "\$${cartItem.product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Total: \$${cartItem.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Quantity controls
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                cartBloc.add(CartDecrementQuantityEvent(
                                  productId: cartItem.product.id,
                                ));
                              },
                              icon: const Icon(Icons.remove, size: 16),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '${cartItem.quantity}', 
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartBloc.add(CartIncrementQuantityEvent(
                                  productId: cartItem.product.id,
                                ));
                              },
                              icon: const Icon(Icons.add, size: 16),
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          cartBloc.add(CartRemoveFromCartEvent(
                            productId: cartItem.product.id,
                          ));
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

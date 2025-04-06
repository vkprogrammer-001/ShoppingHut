import 'package:flutter/material.dart';
import 'package:shopping_hut/core/widgets/add_to_cart_animation.dart';
import 'package:shopping_hut/feature/home/data/model/home_product_data_model.dart';
import 'package:shopping_hut/feature/home/presentation/bloc/home_bloc.dart';
import 'package:shopping_hut/feature/home/presentation/ui/product_detail_page.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: productDataModel,
              homeBloc: homeBloc,
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(productDataModel.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                productDataModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${productDataModel.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductWishlistEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: const Icon(Icons.favorite_border, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  AddToCartButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartEvent(
                          clickedProduct: productDataModel));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_hut/feature/home/model/home_product_data_model.dart';
import 'package:shopping_hut/feature/wishlist/bloc/wishlist_bloc.dart';


class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  const WishlistTileWidget({
    super.key,
    required this.productDataModel,
    required this.wishlistBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(productDataModel.imageURL),
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          productDataModel.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(productDataModel.description),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${productDataModel.price}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(children: [
              IconButton(
                  onPressed: () {
                    wishlistBloc.add(WishlistRemovedFromWishlistEvent(
                        productDataModel: productDataModel));
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              IconButton(
                  onPressed: () {
                    wishlistBloc.add(WishlistProductCartEvent(
                        clickedProduct: productDataModel));
                  },
                  icon: const Icon(Icons.shopping_bag)),
            ])
          ],
        ),
      ]),
    );
  }
}

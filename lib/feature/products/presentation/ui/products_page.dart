import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/products/data/model/product_model.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_bloc.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_event.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_state.dart';
import 'package:shopping_hut/feature/products/presentation/ui/product_detail_page.dart';
import 'package:shopping_hut/feature/products/presentation/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  final String? category;
  
  const ProductsPage({Key? key, this.category}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late TextEditingController _searchController;
  
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    
    if (widget.category != null) {
      context.read<ProductBloc>().add(GetProductsByCategory(widget.category!));
    } else {
      context.read<ProductBloc>().add(GetProducts());
    }
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'All Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filtering
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<ProductBloc>().add(SearchProducts(query));
                } else {
                  if (widget.category != null) {
                    context.read<ProductBloc>().add(GetProductsByCategory(widget.category!));
                  } else {
                    context.read<ProductBloc>().add(GetProducts());
                  }
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductsLoaded) {
                  return _buildProductGrid(state.products);
                } else if (state is ProductError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.message}',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.category != null) {
                              context.read<ProductBloc>().add(GetProductsByCategory(widget.category!));
                            } else {
                              context.read<ProductBloc>().add(GetProducts());
                            }
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No products found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    if (products.isEmpty) {
      return const Center(
        child: Text(
          'No products found',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          product: product,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(productId: product.id),
              ),
            );
          },
        );
      },
    );
  }
} 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_hut/feature/products/data/repositories/product_repository.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_event.dart';
import 'package:shopping_hut/feature/products/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<GetProducts>(_onGetProducts);
    on<GetProductById>(_onGetProductById);
    on<GetProductsByCategory>(_onGetProductsByCategory);
    on<GetProductsOnSale>(_onGetProductsOnSale);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onGetProducts(
    GetProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onGetProductById(
    GetProductById event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final product = await repository.getProductById(event.id);
      emit(ProductLoaded(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProductsByCategory(event.category);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onGetProductsOnSale(
    GetProductsOnSale event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.getProductsOnSale();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await repository.searchProducts(event.query);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
} 
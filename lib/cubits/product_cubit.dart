import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chef_app/models/productModel.dart';
import 'package:chef_app/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  StreamSubscription<List<Product>>? _streamSubscription;

  ProductCubit({required this.productRepository})
    : super(ProductState.initial());

  Future<void> addProduct({
    required String name,
    required List<File> files,
    required String price,
    required List<String> ingredients,
    required String desc,
    required bool pickup,
    required bool delivery,
  }) async {
    if (name.isEmpty || price.isEmpty || desc.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please fill all the fields.',
          isSuccess: false,
          isLoading: false,
        ),
      );
      return;
    }
    if (files.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please upload at least one file',
          isSuccess: false,
          isLoading: false,
        ),
      );
      return;
    }
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: ''));

      final imageUrls = await productRepository.uploadMultipleFiles(files);
      final product = Product(
        productName: name.trim(),
        productImages: imageUrls,
        productPrice: int.parse(price.trim()),
        ingredients: ingredients,
        productDesc: desc.trim(),
        productRating: 0.0,
        delivery: delivery,
        pickup: pickup,
      );
      await productRepository.addProduct(product);
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
          isSuccess: false,
        ),
      );
    }
  }

  void resetState() {
    emit(ProductState.initial());
  }

  StreamSubscription<List<Product>>? _productsSubscription;

  void loadProducts() {
    emit(state.copyWith(isLoading: true));

    _productsSubscription?.cancel();

    _productsSubscription = productRepository.getProducts().listen(
      (products) {
        emit(state.copyWith(products: products, isLoading: false));
      },
      onError: (error) {
        emit(state.copyWith(isLoading: false));
        print("Error loading products: $error");
      },
    );
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}

part of 'product_cubit.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;
  final List<Product> products;

  const ProductState({
    required this.isLoading,
    required this.errorMessage,
    required this.isSuccess,
    required this.products,
  });

  factory ProductState.initial() {
    return ProductState(
      isLoading: false,
      errorMessage: '',
      isSuccess: false,
      products: [],
    );
  }

  @override
  List<Object> get props => [isLoading, errorMessage, isSuccess, products];

  @override
  String toString() {
    return 'ProductState{isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess, products: $products}';
  }

  ProductState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    List<Product>? products,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      products: products ?? this.products,
    );
  }
}

part of 'product_cubit.dart';

class ProductState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final bool isSuccess;

  const ProductState({
    required this.isLoading,
    required this.errorMessage,
    required this.isSuccess,
  });

  factory ProductState.initial() {
    return ProductState(isLoading: false, errorMessage: '', isSuccess: false);
  }

  @override
  List<Object> get props => [isLoading, errorMessage, isSuccess];

  @override
  String toString() {
    return 'ProductState{isLoading: $isLoading, errorMessage: $errorMessage, isSuccess: $isSuccess}';
  }

  ProductState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

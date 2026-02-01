import 'package:bloc/bloc.dart';
import 'package:chef_app/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository})
    : super(ProductState.initial());
}

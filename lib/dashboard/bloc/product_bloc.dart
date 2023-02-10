import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/model/product.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final productRepository = ProductRepository();

  ProductBloc() : super(ProductInitial()) {
    on<InitializeProduct>((event, emit) async {
      emit(ProductLoading());
      await productRepository.getProduct().then((product) {
        emit(ProductLoaded(product));
      }).onError((error, stackTrace) {
        emit(ProductLoadFailed(error.toString()));
      });
    });
  }
}

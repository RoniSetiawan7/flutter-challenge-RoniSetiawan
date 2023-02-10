part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> product;

  const ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class ProductLoadFailed extends ProductState {
  final String message;

  const ProductLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}

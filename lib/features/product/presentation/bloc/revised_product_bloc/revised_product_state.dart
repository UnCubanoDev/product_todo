part of 'revised_product_bloc.dart';

sealed class RevisedProductState {}

final class RevisedProductLoading extends RevisedProductState {}

final class RevisedProductInitial extends RevisedProductState {}

final class RevisedProductList extends RevisedProductState {
  final List<Product> products;

  RevisedProductList({required this.products});
}

final class RevisedProductFailure extends RevisedProductState {
  final Failure failure;

  RevisedProductFailure({required this.failure});
}

class RevisedProductListLoaded extends RevisedProductState {
  final List<Product> products;
  final bool hasReachedMax;

  RevisedProductListLoaded(
      {required this.products, this.hasReachedMax = false});
}

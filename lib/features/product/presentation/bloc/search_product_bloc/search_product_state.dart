part of 'search_product_bloc.dart';

sealed class SearchProductState {}


final class SearchProductLoading extends SearchProductState {}
final class SearchProductInitial extends SearchProductState {}

final class SearchProductList extends SearchProductState {
  final List<Product> products;

  SearchProductList({required this.products});
}

final class SearchProductFailure extends SearchProductState {
  final Failure failure;

  SearchProductFailure({required this.failure});
}

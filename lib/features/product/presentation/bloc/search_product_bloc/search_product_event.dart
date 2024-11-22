part of 'search_product_bloc.dart';

sealed class SearchProductEvent {}

class OnPostProduct extends SearchProductEvent {
  final Product product;
  OnPostProduct({required this.product});
}
class OnPutProduct extends SearchProductEvent {
  final Product product;
  OnPutProduct({required this.product});
}

class OnGetProducts extends SearchProductEvent {
  OnGetProducts();
}

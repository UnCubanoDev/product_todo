// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'revised_product_bloc.dart';

sealed class RevisedProductEvent {}

class OnRevisedProductInitial extends RevisedProductEvent {}

class OnRevisedProductLoading extends RevisedProductEvent {}

class OnRevisedProductSuccess extends RevisedProductEvent {
  final List<Product> products;
  final bool hasMore;
  OnRevisedProductSuccess({
    required this.products,
    required this.hasMore,
  });
}

class OnPostProduct extends RevisedProductEvent {
  final Product product;
  OnPostProduct({required this.product});
}

class OnPutProduct extends RevisedProductEvent {
  final Product product;
  OnPutProduct({required this.product});
}

class OnGetProducts extends RevisedProductEvent {
  OnGetProducts();
}

class OnGetLocalProducts extends RevisedProductEvent {
  
  OnGetLocalProducts();
}

class OnDeleteProduct extends RevisedProductEvent {
  final String id;
  OnDeleteProduct({required this.id});
}

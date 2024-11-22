// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';

import 'package:product_todo/features/product/domain/usecases/get_product.dart';
import 'package:product_todo/features/product/domain/usecases/post_product.dart';
import 'package:product_todo/features/product/domain/usecases/put_product.dart';

part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final GetProduct _getProductUseCase;
  final PostProduct _postProductUseCase;
  final PutProduct _putProductUseCase;
  int page = 0;
  final int pageSize = 7;
  final List<Product> products = [];

  SearchProductBloc(
    this._getProductUseCase,
    this._postProductUseCase,
    this._putProductUseCase,
  ) : super(SearchProductInitial()) {
    on<OnGetProducts>((event, emit) async {
      emit(SearchProductLoading());
      final res = await _getProductUseCase();
      res.fold(
          (f) => emit(SearchProductFailure(failure: f)),
          (p) => emit(SearchProductList(
              products: p
                  .where((p) => p.approved != true && p.refused != true)
                  .toList())));
    });

    on<OnPostProduct>((event, emit) async {
      final res = await _postProductUseCase(event.product);
      res.fold((f) => emit(SearchProductFailure(failure: f)), (p) {});
    });

    on<OnPutProduct>((event, emit) async {
      final res = await _putProductUseCase(event.product);
      res.fold((f) => emit(SearchProductFailure(failure: f)), (p) {
        add(OnGetProducts());
      });
    });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first, unrelated_type_equality_checks

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/domain/usecases/delete_product.dart';
import 'package:product_todo/features/product/domain/usecases/get_local_product.dart';

part 'revised_product_event.dart';
part 'revised_product_state.dart';

class RevisedProductBloc
    extends Bloc<RevisedProductEvent, RevisedProductState> {
  final GetLocalProduct _getProductLocalUseCase;
  final DeleteProductLocal _deleteProductUseCase;
  int currentPage = 1;
  final List<Product> products = [];

  RevisedProductBloc(
    this._getProductLocalUseCase,
    this._deleteProductUseCase,
  ) : super(RevisedProductInitial()) {
    on<OnGetLocalProducts>((event, emit) async {
      emit(RevisedProductLoading());
      try {
        final res = await _getProductLocalUseCase(currentPage);

        res.fold(
          (f) => emit(RevisedProductFailure(failure: f)),
          (p) {
            products.addAll(p);
            currentPage++;
            emit(RevisedProductList(products: products));
          },
        );
      } catch (e) {
        emit(RevisedProductFailure(failure: LocalFailure()));
      }
    });
    on<OnDeleteProduct>((event, emit) async {
      emit(RevisedProductLoading());
      final res = await _deleteProductUseCase(event.id.toString());
      res.fold((f) => emit(RevisedProductFailure(failure: f)),
          (p) => add(OnGetLocalProducts()));
    });
  }
}

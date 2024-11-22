import 'package:dartz/dartz.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/domain/repositories/product_repository.dart';

class GetLocalProduct {
  final ProductRepository repository;

  GetLocalProduct({required this.repository});

  Future<Either<Failure, List<Product>>> call(int page) {
    return repository.getProductsLocal(page);
  }
}

import 'package:dartz/dartz.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/domain/repositories/product_repository.dart';

class PutProduct {
  final ProductRepository repository;

  PutProduct({required this.repository});

  Future<Either<Failure, bool>> call(Product product) {
    return repository.putProducts(product);
  }
}

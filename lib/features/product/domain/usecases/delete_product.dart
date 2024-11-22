import 'package:dartz/dartz.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/domain/repositories/product_repository.dart';

class DeleteProductLocal {
  final ProductRepository repository;

  DeleteProductLocal({required this.repository});

  Future<Either<Failure, bool>> call(String id) {
    return repository.deleteProduct(id.toString());
  }
}

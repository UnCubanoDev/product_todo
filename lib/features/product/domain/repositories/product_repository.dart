import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProductsLocal(int page);
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, bool>> postProducts(Product product);
  Future<Either<Failure, bool>> putProducts(Product product);
  Future<Either<Failure, bool>> deleteProduct(String string);
}

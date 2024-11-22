import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/data/datasource/local/product_local_datasource.dart';
import 'package:product_todo/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';
import 'package:product_todo/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;
  final ProductRemoteDataSource productRemoteDataSource;
  static const int productsPerPage = 7;
  ProductRepositoryImpl(
      {required this.productLocalDataSource,
      required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getProductsLocal(int page) async {
    try {
      final int startIndex = (page - 1) * productsPerPage;
      final products =
          await productLocalDataSource.getProductsLocal();
      if (startIndex >= products.length) {
        return const Right([]); // Retorna lista vacía si la página solicitada está fuera de rango
      }
      final endIndex = startIndex + productsPerPage;
      return Right(products.sublist(
          startIndex, endIndex > products.length ? products.length : endIndex));
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postProducts(Product product) async {
    try {
      final bool res = await productLocalDataSource.postProduct(product);
      return Right(res);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> putProducts(Product product) async {
    try {
      final bool res = await productLocalDataSource.postProduct(product);
      final bool res2 = await productRemoteDataSource.putProducts(product);
      return Right(res && res2);
    } on LocalFailure {
      return Left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final List<Product> res = await productRemoteDataSource.getProducts();
      return Right(res);
    } on DioException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    try {
      final bool res = await productLocalDataSource.deleteProduct(id);
      final bool res2 = await productRemoteDataSource.deleteProducts(id);
      return Right(res && res2);
    } on DioException {
      return Left(ServerFailure());
    }
  }
}

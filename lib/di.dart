import 'package:get_it/get_it.dart';
import 'package:product_todo/features/product/data/datasource/local/product_local_datasource.dart';
import 'package:product_todo/features/product/data/datasource/remote/product_remote_datasource.dart';
import 'package:product_todo/features/product/data/repositories/product_repository_impl.dart';
import 'package:product_todo/features/product/domain/repositories/product_repository.dart';
import 'package:product_todo/features/product/domain/usecases/delete_product.dart';
import 'package:product_todo/features/product/domain/usecases/get_local_product.dart';
import 'package:product_todo/features/product/domain/usecases/get_product.dart';
import 'package:product_todo/features/product/domain/usecases/post_product.dart';
import 'package:product_todo/features/product/domain/usecases/put_product.dart';
import 'package:product_todo/features/product/presentation/bloc/revised_product_bloc/revised_product_bloc.dart';
import 'package:product_todo/features/product/presentation/bloc/search_product_bloc/search_product_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  // Bloc
  di.registerFactory(
    () => SearchProductBloc(
      di(),
      di(),
      di(),
    ),
  );
  di.registerFactory(
    () => RevisedProductBloc(
      di(),
      di(),
    ),
  );

  // Use Case
  di.registerLazySingleton(() => GetProduct(repository: di()));
  di.registerLazySingleton(() => PostProduct(repository: di()));
  di.registerLazySingleton(() => PutProduct(repository: di()));
  di.registerLazySingleton(() => GetLocalProduct(repository: di()));
  di.registerLazySingleton(() => DeleteProductLocal(repository: di()));

  // Repositories
  di.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      productLocalDataSource: di(), productRemoteDataSource: di()));

  // Datasource
  di.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  di.registerLazySingleton<ProductLocalDataSource>(
      () => HiveProductLocalDataSourceImpl());
}

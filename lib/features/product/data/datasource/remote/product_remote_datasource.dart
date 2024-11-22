
import 'package:dio/dio.dart';
import 'package:product_todo/features/product/data/models/product_model.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<bool> putProducts(Product product);
  Future<bool> deleteProducts(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<List<ProductModel>> getProducts() async {
    final res = await dio
        .get('https://6737d1414eb22e24fca63a45.mockapi.io/api/v1/products');
    List<ProductModel> products = [];
    for (Map<String,dynamic> product in res.data) {
      products.add(ProductModel.fromJson(product));
    }
    return products;
  }
  
  @override
  Future<bool> putProducts(Product product) async {
    final res = await dio
        .put('https://6737d1414eb22e24fca63a45.mockapi.io/api/v1/products/${product.id.toString()}', data: ProductModel.fromEntity(product).toJson());
    return res.statusCode == 200;
  }
  
  @override
  Future<bool> deleteProducts(String id) async {
    final res = await dio
        .delete('https://6737d1414eb22e24fca63a45.mockapi.io/api/v1/products/${id.toString()}');
    return res.statusCode == 200;
  }
}

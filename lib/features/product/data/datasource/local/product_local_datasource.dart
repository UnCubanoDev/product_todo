import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_todo/core/error/failures.dart';
import 'package:product_todo/features/product/data/models/product_model.dart';
import 'package:product_todo/features/product/domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<bool> postProduct(Product product);
  Future<bool> putProduct(Product product);
  Future<List<ProductModel>> getProductsLocal();

  deleteProduct(String id) {}
}

class HiveProductLocalDataSourceImpl implements ProductLocalDataSource {
  HiveProductLocalDataSourceImpl() {
    Hive.initFlutter();
  }

  @override
  Future<List<ProductModel>> getProductsLocal() async {
    try {
      final box = await Hive.openBox('products');
      final allProducts =
          box.values.map((p) => ProductModel.fromJson(p)).toList();
      return allProducts;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> postProduct(Product product) async {
    try {
      final box = await Hive.openBox('products');
      box.put(product.id.toString(), ProductModel.fromEntity(product).toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> putProduct(Product product) async {
    try {
      final box = await Hive.openBox('products');
      box.put(product.id, ProductModel.fromEntity(product).toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<bool> deleteProduct(String id) async {
    try {
      final box = await Hive.openBox('products');
      box.delete(id);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }
}

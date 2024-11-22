import 'package:product_todo/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.createdAt,
    required super.name,
    required super.image,
    required super.approved,
    required super.description,
    required super.refused,
    required super.id,
  });

  factory ProductModel.fromJson(json) {
    return ProductModel(
        createdAt: json['createdAt'],
        name: json['name'],
        image: json['image'],
        approved: json['approved'],
        description: json['description'],
        refused: json['refused'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'approved': approved,
      'refused': refused,
      'createdAt': createdAt
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
        createdAt: product.createdAt,
        name: product.name,
        image: product.image,
        approved: product.approved,
        description: product.description,
        refused: product.refused,
        id: product.id);
  }
}

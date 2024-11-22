// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? createdAt;
  String? name;
  String? image;
  bool? approved;
  String? description;
  bool? refused;
  String? id;
  
  Product({
    this.createdAt,
    this.name,
    this.image,
    this.approved,
    this.description,
    this.refused,
    this.id,
  });

  Product copyWith({
    String? createdAt,
    String? name,
    String? image,
    bool? approved,
    String? description,
    bool? refused,
    String? id,
  }) {
    return Product(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      image: image ?? this.image,
      approved: approved ?? this.approved,
      description: description ?? this.description,
      refused: refused ?? this.refused,
      id: id ?? this.id,
    );
  }
}

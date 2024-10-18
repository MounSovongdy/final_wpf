import 'dart:convert';

class ProductModel {
  final String id;
  final String model;
  final String brand;

  ProductModel({
    this.id = 'id',
    this.model = 'model',
    this.brand = 'brand',
  });

  ProductModel copyWith({
    String? id,
    String? model,
    String? brand,
    String? year,
  }) {
    return ProductModel(
      id: id ?? this.id,
      model: model ?? this.model,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      model: map['model'] as String,
      brand: map['brand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, model: $model, brand: $brand)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.model == model && other.brand == brand;
  }

  @override
  int get hashCode {
    return id.hashCode ^ model.hashCode ^ brand.hashCode;
  }
}

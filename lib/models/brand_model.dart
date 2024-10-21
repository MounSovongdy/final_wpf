import 'dart:convert';

class BrandModel {
  final int id;
  final String brand;
  
  BrandModel({
    required this.id,
    required this.brand,
  });

  BrandModel copyWith({
    int? id,
    String? brand,
  }) {
    return BrandModel(
      id: id ?? this.id,
      brand: brand ?? this.brand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'brand': brand,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as int,
      brand: map['brand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) => BrandModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BrandModel(id: $id, brand: $brand)';

  @override
  bool operator ==(covariant BrandModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.brand == brand;
  }

  @override
  int get hashCode => id.hashCode ^ brand.hashCode;
}

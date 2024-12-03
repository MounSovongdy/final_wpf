import 'dart:convert';

class StockDetailModel {
  final int id;
  final String model;
  final String brand;
  final String year;
  final String condition;
  final String price;
  final String totalQty;
  final String leftQty;

  StockDetailModel({
    required this.id,
    required this.model,
    required this.brand,
    required this.year,
    required this.condition,
    required this.price,
    required this.totalQty,
    required this.leftQty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
      'condition': condition,
      'price': price,
      'total_qty': totalQty,
      'left_qty': leftQty,
    };
  }

  factory StockDetailModel.fromMap(Map<String, dynamic> map) {
    return StockDetailModel(
      id: map['id'] as int,
      model: map['model'] as String,
      brand: map['brand'] as String,
      year: map['year'] as String,
      condition: map['condition'] as String,
      price: map['price'] as String,
      totalQty: map['total_qty'] as String,
      leftQty: map['left_qty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockDetailModel.fromJson(String source) => StockDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

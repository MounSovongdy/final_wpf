import 'dart:convert';

class TotalStockModel {
  final String id;
  final String model;
  final String brand;
  final String year;
  final String condition;
  final String oldDateIn;
  final String newDateIn;
  final String oldQty;
  final String newQty;
  final String totalQty;
  final String oldPrice;
  final String newPrice;
  final String oldTotalPrice;
  final String newTotalPrice;

  TotalStockModel({
    this.id = 'id',
    this.model = 'model',
    this.brand = 'brand',
    this.year = 'year',
    this.condition = 'condition',
    this.oldDateIn = 'old_date_in',
    this.newDateIn = 'new_date_in',
    this.oldQty = 'old_qty',
    this.newQty = 'new_qty',
    this.totalQty = 'total_qty',
    this.oldPrice = 'old_price',
    this.newPrice = 'new_price',
    this.oldTotalPrice = 'old_total_price',
    this.newTotalPrice = 'new_total_price',
  });

  TotalStockModel copyWith({
    String? id,
    String? model,
    String? brand,
    String? year,
    String? condition,
    String? oldDateIn,
    String? newDateIn,
    String? oldQty,
    String? newQty,
    String? totalQty,
    String? oldPrice,
    String? newPrice,
    String? oldTotalPrice,
    String? newTotalPrice,
  }) {
    return TotalStockModel(
      id: id ?? this.id,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      year: year ?? this.year,
      condition: condition ?? this.condition,
      oldDateIn: oldDateIn ?? this.oldDateIn,
      newDateIn: newDateIn ?? this.newDateIn,
      oldQty: oldQty ?? this.oldQty,
      newQty: newQty ?? this.newQty,
      totalQty: totalQty ?? this.totalQty,
      oldPrice: oldPrice ?? this.oldPrice,
      newPrice: newPrice ?? this.newPrice,
      oldTotalPrice: oldTotalPrice ?? this.oldTotalPrice,
      newTotalPrice: newTotalPrice ?? this.newTotalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
      'condition': condition,
      'old_date_in': oldDateIn,
      'new_date_in': newDateIn,
      'old_qty': oldQty,
      'new_qty': newQty,
      'total_qty': totalQty,
      'old_price': oldPrice,
      'new_price': newPrice,
      'old_total_price': oldTotalPrice,
      'new_total_price': newTotalPrice,
    };
  }

  factory TotalStockModel.fromMap(Map<String, dynamic> map) {
    return TotalStockModel(
      id: map['id'] as String,
      model: map['model'] as String,
      brand: map['brand'] as String,
      year: map['year'] as String,
      condition: map['condition'] as String,
      oldDateIn: map['old_date_in'] as String,
      newDateIn: map['new_date_in'] as String,
      oldQty: map['old_qty'] as String,
      newQty: map['new_qty'] as String,
      totalQty: map['total_qty'] as String,
      oldPrice: map['old_price'] as String,
      newPrice: map['new_price'] as String,
      oldTotalPrice: map['old_total_price'] as String,
      newTotalPrice: map['new_total_price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalStockModel.fromJson(String source) =>
      TotalStockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TotalStockModel(id: $id, model: $model, brand: $brand, year: $year, condition: $condition, old_date_in: $oldDateIn, new_date_in: $newDateIn, old_qty: $oldQty, new_qty: $newQty, total_qty: $totalQty, old_price: $oldPrice, new_price: $newPrice, old_total_price: $oldTotalPrice, new_total_price: $newTotalPrice)';
  }

  @override
  bool operator ==(covariant TotalStockModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.model == model &&
        other.brand == brand &&
        other.year == year &&
        other.condition == condition &&
        other.oldDateIn == oldDateIn &&
        other.newDateIn == newDateIn &&
        other.oldQty == oldQty &&
        other.newQty == newQty &&
        other.totalQty == totalQty &&
        other.oldPrice == oldPrice &&
        other.newPrice == newPrice &&
        other.oldTotalPrice == oldTotalPrice &&
        other.newTotalPrice == newTotalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        model.hashCode ^
        brand.hashCode ^
        year.hashCode ^
        condition.hashCode ^
        oldDateIn.hashCode ^
        newDateIn.hashCode ^
        oldQty.hashCode ^
        newQty.hashCode ^
        totalQty.hashCode ^
        oldPrice.hashCode ^
        newPrice.hashCode ^
        oldTotalPrice.hashCode ^
        newTotalPrice.hashCode;
  }
}

import 'dart:convert';

class TotalStockModel {
  final String id;
  final String model;
  final String brand;
  final String year;
  final String condition;
  final String dateIn;
  final String oldQty;
  final String newQty;
  final String totalQty;
  final String oldPrice;
  final String newPrice;
  final String oldTotalQty;
  final String newTotalQty;

  TotalStockModel({
    this.id = 'id',
    this.model = 'model',
    this.brand = 'brand',
    this.year = 'year',
    this.condition = 'condition',
    this.dateIn = 'date_in',
    this.oldQty = 'old_qty',
    this.newQty = 'new_qty',
    this.totalQty = 'total_qty',
    this.oldPrice = 'old_price',
    this.newPrice = 'new_price',
    this.oldTotalQty = 'old_total_qty',
    this.newTotalQty = 'new_total_qty',
  });

  TotalStockModel copyWith({
    String? id,
    String? model,
    String? brand,
    String? year,
    String? condition,
    String? dateIn,
    String? oldQty,
    String? newQty,
    String? totalQty,
    String? oldPrice,
    String? newPrice,
    String? oldTotalQty,
    String? newTotalQty,
  }) {
    return TotalStockModel(
      id: id ?? this.id,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      year: year ?? this.year,
      condition: condition ?? this.condition,
      dateIn: dateIn ?? this.dateIn,
      oldQty: oldQty ?? this.oldQty,
      newQty: newQty ?? this.newQty,
      totalQty: totalQty ?? this.totalQty,
      oldPrice: oldPrice ?? this.oldPrice,
      newPrice: newPrice ?? this.newPrice,
      oldTotalQty: oldTotalQty ?? this.oldTotalQty,
      newTotalQty: newTotalQty ?? this.newTotalQty,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'model': model,
      'brand': brand,
      'year': year,
      'condition': condition,
      'date_in': dateIn,
      'old_qty': oldQty,
      'new_qty': newQty,
      'total_qty': totalQty,
      'old_price': oldPrice,
      'new_price': newPrice,
      'old_total_qty': oldTotalQty,
      'new_total_qty': newTotalQty,
    };
  }

  factory TotalStockModel.fromMap(Map<String, dynamic> map) {
    return TotalStockModel(
      id: map['id'] as String,
      model: map['model'] as String,
      brand: map['brand'] as String,
      year: map['year'] as String,
      condition: map['condition'] as String,
      dateIn: map['date_in'] as String,
      oldQty: map['old_qty'] as String,
      newQty: map['new_qty'] as String,
      totalQty: map['total_qty'] as String,
      oldPrice: map['old_price'] as String,
      newPrice: map['new_price'] as String,
      oldTotalQty: map['old_total_qty'] as String,
      newTotalQty: map['new_total_qty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalStockModel.fromJson(String source) =>
      TotalStockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TotalStockModel(id: $id, model: $model, brand: $brand, year: $year, condition: $condition, date_in: $dateIn, old_qty: $oldQty, new_qty: $newQty, total_qty: $totalQty, old_price: $oldPrice, new_price: $newPrice, old_total_qty: $oldTotalQty, new_total_qty: $newTotalQty)';
  }

  @override
  bool operator ==(covariant TotalStockModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.model == model &&
        other.brand == brand &&
        other.year == year &&
        other.condition == condition &&
        other.dateIn == dateIn &&
        other.oldQty == oldQty &&
        other.newQty == newQty &&
        other.totalQty == totalQty &&
        other.oldPrice == oldPrice &&
        other.newPrice == newPrice &&
        other.oldTotalQty == oldTotalQty &&
        other.newTotalQty == newTotalQty;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        model.hashCode ^
        brand.hashCode ^
        year.hashCode ^
        condition.hashCode ^
        dateIn.hashCode ^
        oldQty.hashCode ^
        newQty.hashCode ^
        totalQty.hashCode ^
        oldPrice.hashCode ^
        newPrice.hashCode ^
        oldTotalQty.hashCode ^
        newTotalQty.hashCode;
  }
}

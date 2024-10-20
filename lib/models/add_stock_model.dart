import 'dart:convert';

class AddStockModel {
  final int id;
  final String model;
  final String brand;
  final String year;
  final String condition;
  final String oldDateIn;
  final String oldQty;
  final String oldPrice;
  final String oldTotalPrice;
  final String dateIn;
  final String qty;
  final String price;
  final String totalPrice;

  AddStockModel({
    this.id = 0,
    this.model = '',
    this.brand = '',
    this.year = '',
    this.condition = '',
    this.oldDateIn = '',
    this.oldQty = '',
    this.oldPrice = '',
    this.oldTotalPrice = '',
    this.dateIn = '',
    this.qty = '',
    this.price = '',
    this.totalPrice = '',
  });

  AddStockModel copyWith({
    int? id,
    String? model,
    String? brand,
    String? year,
    String? condition,
    String? oldDateIn,
    String? oldQty,
    String? oldPrice,
    String? oldTotalPrice,
    String? dateIn,
    String? qty,
    String? price,
    String? totalPrice,
  }) {
    return AddStockModel(
      id: id ?? this.id,
      model: model ?? this.model,
      brand: brand ?? this.brand,
      year: year ?? this.year,
      condition: condition ?? this.condition,
      oldDateIn: oldDateIn ?? this.oldDateIn,
      oldQty: oldQty ?? this.oldQty,
      oldPrice: oldPrice ?? this.oldPrice,
      oldTotalPrice: oldTotalPrice ?? this.oldTotalPrice,
      dateIn: dateIn ?? this.dateIn,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      totalPrice: totalPrice ?? this.totalPrice,
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
      'old_qty': oldQty,
      'old_price': oldPrice,
      'old_total_price': oldTotalPrice,
      'date_in': dateIn,
      'qty': qty,
      'price': price,
      'total_price': totalPrice,
    };
  }

  factory AddStockModel.fromMap(Map<String, dynamic> map) {
    return AddStockModel(
      id: map['id'] as int,
      model: map['model'] as String,
      brand: map['brand'] as String,
      year: map['year'] as String,
      condition: map['condition'] as String,
      oldDateIn: map['old_date_in'] as String,
      oldQty: map['old_qty'] as String,
      oldPrice: map['old_price'] as String,
      oldTotalPrice: map['old_total_price'] as String,
      dateIn: map['date_in'] as String,
      qty: map['qty'] as String,
      price: map['price'] as String,
      totalPrice: map['total_price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStockModel.fromJson(String source) =>
      AddStockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddStockModel(id: $id, model: $model, brand: $brand, year: $year, condition: $condition, old_date_in: $oldDateIn, old_qty: $oldQty, old_price: $oldPrice, old_total_price: $oldTotalPrice, date_in: $dateIn, qty: $qty, price: $price, total_price: $totalPrice)';
  }

  @override
  bool operator ==(covariant AddStockModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.model == model &&
      other.brand == brand &&
      other.year == year &&
      other.condition == condition &&
      other.oldDateIn == oldDateIn &&
      other.oldQty == oldQty &&
      other.oldPrice == oldPrice &&
      other.oldTotalPrice == oldTotalPrice &&
      other.dateIn == dateIn &&
      other.qty == qty &&
      other.price == price &&
      other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      model.hashCode ^
      brand.hashCode ^
      year.hashCode ^
      condition.hashCode ^
      oldDateIn.hashCode ^
      oldQty.hashCode ^
      oldPrice.hashCode ^
      oldTotalPrice.hashCode ^
      dateIn.hashCode ^
      qty.hashCode ^
      price.hashCode ^
      totalPrice.hashCode;
  }
}

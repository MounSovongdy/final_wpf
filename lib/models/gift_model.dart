import 'dart:convert';

class GiftModel {
  final int id;
  final String year;
  final String month;
  final String date;
  final String item;
  final String amount;

  GiftModel({
    required this.id,
    required this.year,
    required this.month,
    required this.date,
    required this.item,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'date': date,
      'item': item,
      'amount': amount,
    };
  }

  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      date: map['date'] as String,
      item: map['item'] as String,
      amount: map['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GiftModel.fromJson(String source) =>
      GiftModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

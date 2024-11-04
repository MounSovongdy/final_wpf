import 'dart:convert';

class AdvertisingModel {
  final int id;
  final String year;
  final String month;
  final String date;
  final String detail;
  final String amount;

  AdvertisingModel({
    required this.id,
    required this.year,
    required this.month,
    required this.date,
    required this.detail,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'date': date,
      'detail': detail,
      'amount': amount,
    };
  }

  factory AdvertisingModel.fromMap(Map<String, dynamic> map) {
    return AdvertisingModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      date: map['date'] as String,
      detail: map['detail'] as String,
      amount: map['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvertisingModel.fromJson(String source) =>
      AdvertisingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class RentalModel {
  final int id;
  final String year;
  final String month;
  final String date;
  final String detail;
  final String amount;

  RentalModel({
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

  factory RentalModel.fromMap(Map<String, dynamic> map) {
    return RentalModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      date: map['date'] as String,
      detail: map['detail'] as String,
      amount: map['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RentalModel.fromJson(String source) =>
      RentalModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

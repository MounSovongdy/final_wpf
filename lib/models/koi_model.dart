import 'dart:convert';

class KoiModel {
  final int id;
  final String year;
  final String month;
  final String date;
  final String name;
  final String amount;

  KoiModel({
    required this.id,
    required this.year,
    required this.month,
    required this.date,
    required this.name,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'date': date,
      'name': name,
      'amount': amount,
    };
  }

  factory KoiModel.fromMap(Map<String, dynamic> map) {
    return KoiModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      date: map['date'] as String,
      name: map['name'] as String,
      amount: map['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory KoiModel.fromJson(String source) =>
      KoiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

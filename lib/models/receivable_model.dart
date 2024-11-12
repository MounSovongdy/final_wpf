import 'dart:convert';

class ReceivableModel {
  final int id;
  final String saleman;
  final String date;
  final String name;
  final String tel1;
  final String tel2;
  final String tel3;
  final String document;
  final String brand;
  final String model;
  final String year;
  final String color;
  final String power;
  final String condition;
  final String firstPayment;
  final String interest;
  final String total;
  final String term;
  final String platePayment;
  final String plateAmount;
  final String receiveAmount;
  final String amountLeft;
  final String penalty;

  ReceivableModel({
    required this.id,
    required this.saleman,
    required this.date,
    required this.name,
    required this.tel1,
    required this.tel2,
    required this.tel3,
    required this.document,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.power,
    required this.condition,
    required this.firstPayment,
    required this.interest,
    required this.total,
    required this.term,
    required this.platePayment,
    required this.plateAmount,
    required this.receiveAmount,
    required this.amountLeft,
    required this.penalty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'saleman': saleman,
      'date': date,
      'name': name,
      'tel1': tel1,
      'tel2': tel2,
      'tel3': tel3,
      'document': document,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'power': power,
      'condition': condition,
      'first_payment': firstPayment,
      'interest': interest,
      'total': total,
      'term': term,
      'plate_payment': platePayment,
      'plate_amount': plateAmount,
      'receive_amount': receiveAmount,
      'amount_left': amountLeft,
      'penalty': penalty,
    };
  }

  factory ReceivableModel.fromMap(Map<String, dynamic> map) {
    return ReceivableModel(
      id: map['id'] as int,
      saleman: map['saleman'] as String,
      date: map['date'] as String,
      name: map['name'] as String,
      tel1: map['tel1'] as String,
      tel2: map['tel2'] as String,
      tel3: map['tel3'] as String,
      document: map['document'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as String,
      color: map['color'] as String,
      power: map['power'] as String,
      condition: map['condition'] as String,
      firstPayment: map['first_payment'] as String,
      interest: map['interest'] as String,
      total: map['total'] as String,
      term: map['term'] as String,
      platePayment: map['plate_payment'] as String,
      plateAmount: map['plate_amount'] as String,
      receiveAmount: map['receive_amount'] as String,
      amountLeft: map['amount_left'] as String,
      penalty: map['penalty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceivableModel.fromJson(String source) =>
      ReceivableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class PaymentTableModel {
  final int id;
  final int no;
  final String type;
  final String date;
  final String amount;
  final String note;
  final String paid;
  final String paidDate;
  final String lateDate;
  final String penalty;

  PaymentTableModel({
    required this.id,
    required this.no,
    required this.type,
    required this.date,
    required this.amount,
    required this.note,
    required this.paid,
    required this.paidDate,
    required this.lateDate,
    required this.penalty,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'no': no,
      'type': type,
      'date': date,
      'amount': amount,
      'note': note,
      'paid': paid,
      'paid_date': paidDate,
      'late_date': lateDate,
      'penalty': penalty,
    };
  }

  factory PaymentTableModel.fromMap(Map<String, dynamic> map) {
    return PaymentTableModel(
      id: map['id'] as int,
      no: map['no'] as int,
      type: map['type'] as String,
      date: map['date'] as String,
      amount: map['amount'] as String,
      note: map['note'] as String,
      paid: map['paid'] as String,
      paidDate: map['paid_date'] as String,
      lateDate: map['late_date'] as String,
      penalty: map['penalty'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentTableModel.fromJson(String source) => PaymentTableModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class MicroCommissionModel {
  final int id;
  final String year;
  final String month;
  final int microId;
  final String microName;
  final String tBonus;
  final String unitSale;
  final String totalBonus;

  MicroCommissionModel({
    this.id = 0,
    this.year = '',
    this.month = '',
    this.microId = 0,
    this.microName = '',
    this.tBonus = '',
    this.unitSale = '',
    this.totalBonus = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'micro_id': microId,
      'micro_name': microName,
      'tBonus': tBonus,
      'unit_sale': unitSale,
      'total_bonus': totalBonus,
    };
  }

  factory MicroCommissionModel.fromMap(Map<String, dynamic> map) {
    return MicroCommissionModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      microId: map['micro_id'] as int,
      microName: map['micro_name'] as String,
      tBonus: map['tBonus'] as String,
      unitSale: map['unit_sale'] as String,
      totalBonus: map['total_bonus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MicroCommissionModel.fromJson(String source) => MicroCommissionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

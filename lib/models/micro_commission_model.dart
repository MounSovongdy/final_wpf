import 'dart:convert';

class MicroCommissionModel {
  final int id;
  final int leasingId;
  final String leasingDate;
  final int microId;
  final String microName;
  final String tBonus;
  final String unitSale;
  final String totalBonus;

  MicroCommissionModel({
    required this.id,
    required this.leasingId,
    required this.leasingDate,
    required this.microId,
    required this.microName,
    required this.tBonus,
    required this.unitSale,
    required this.totalBonus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'leasing_id': leasingId,
      'leasing_date': leasingDate,
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
      leasingId: map['leasing_id'] as int,
      leasingDate: map['leasing_date'] as String,
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

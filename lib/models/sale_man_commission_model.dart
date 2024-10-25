import 'dart:convert';

class SaleManCommissionModel {
  final int id;
  final int leasingId;
  final String leasingDate;
  final int saleManId;
  final String saleManName;
  final String saleBonus;
  final String unitSale;
  final String totalBonus;

  SaleManCommissionModel({
    this.id = 0,
    this.leasingId = 0,
    this.leasingDate = '',
    this.saleManId = 0,
    this.saleManName = '',
    this.saleBonus = '',
    this.unitSale = '',
    this.totalBonus = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'leasing_id': leasingId,
      'leasing_date': leasingDate,
      'sale_man_id': saleManId,
      'sale_man_name': saleManName,
      'sale_bonus': saleBonus,
      'unit_sale': unitSale,
      'total_bonus': totalBonus,
    };
  }

  factory SaleManCommissionModel.fromMap(Map<String, dynamic> map) {
    return SaleManCommissionModel(
      id: map['id'] as int,
      leasingId: map['leasing_id'] as int,
      leasingDate: map['leasing_date'] as String,
      saleManId: map['sale_man_id'] as int,
      saleManName: map['sale_man_name'] as String,
      saleBonus: map['sale_bonus'] as String,
      unitSale: map['unit_sale'] as String,
      totalBonus: map['total_bonus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleManCommissionModel.fromJson(String source) => SaleManCommissionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

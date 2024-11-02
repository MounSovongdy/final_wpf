import 'dart:convert';

class SaleManCommissionModel {
  final int id;
  final String year;
  final String month;
  final int saleManId;
  final String saleManName;
  final String saleSalary;
  final String saleBonus;
  final String unitSale;
  final String totalBonus;

  SaleManCommissionModel({
    this.id = 0,
    this.year = '',
    this.month = '',
    this.saleManId = 0,
    this.saleManName = '',
    this.saleSalary = '',
    this.saleBonus = '',
    this.unitSale = '',
    this.totalBonus = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'sale_man_id': saleManId,
      'sale_man_name': saleManName,
      'sale_salary': saleSalary,
      'sale_bonus': saleBonus,
      'unit_sale': unitSale,
      'total_bonus': totalBonus,
    };
  }

  factory SaleManCommissionModel.fromMap(Map<String, dynamic> map) {
    return SaleManCommissionModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      saleManId: map['sale_man_id'] as int,
      saleManName: map['sale_man_name'] as String,
      saleSalary: map['sale_salary'] as String,
      saleBonus: map['sale_bonus'] as String,
      unitSale: map['unit_sale'] as String,
      totalBonus: map['total_bonus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleManCommissionModel.fromJson(String source) =>
      SaleManCommissionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

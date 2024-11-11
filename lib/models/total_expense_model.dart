import 'dart:convert';

class TotalExpenseModel {
  final int id;
  final String year;
  final String month;
  final String rental;
  final String salaryE;
  final String bonusE;
  final String bonusT;
  final String advertise;
  final String koi;
  final String gift;
  final String commission;
  final String totalExpense;
  final String netSale;
  final String saleRevenue;
  final String totalSale;
  final String avgSaleRevenue;
  final String avgProfit;

  TotalExpenseModel({
    this.id = 0,
    this.year = '',
    this.month = '',
    this.rental = '',
    this.salaryE = '',
    this.bonusE = '',
    this.bonusT = '',
    this.advertise = '',
    this.koi = '',
    this.gift = '',
    this.commission = '',
    this.totalExpense = '',
    this.netSale = '',
    this.saleRevenue = '',
    this.totalSale = '',
    this.avgSaleRevenue = '',
    this.avgProfit = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'rental': rental,
      'salaryE': salaryE,
      'bonusE': bonusE,
      'bonusT': bonusT,
      'advertise': advertise,
      'koi': koi,
      'gift': gift,
      'commission': commission,
      'total_expense': totalExpense,
      'net_sale': netSale,
      'sale_revenue': saleRevenue,
      'total_sale': totalSale,
      'avg_sale_revenue': avgSaleRevenue,
      'avg_profit': avgProfit,
    };
  }

  factory TotalExpenseModel.fromMap(Map<String, dynamic> map) {
    return TotalExpenseModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      rental: map['rental'] as String,
      salaryE: map['salaryE'] as String,
      bonusE: map['bonusE'] as String,
      bonusT: map['bonusT'] as String,
      advertise: map['advertise'] as String,
      koi: map['koi'] as String,
      gift: map['gift'] as String,
      commission: map['commission'] as String,
      totalExpense: map['total_expense'] as String,
      netSale: map['net_sale'] as String,
      saleRevenue: map['sale_revenue'] as String,
      totalSale: map['total_sale'] as String,
      avgSaleRevenue: map['avg_sale_revenue'] as String,
      avgProfit: map['avg_profit'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalExpenseModel.fromJson(String source) => TotalExpenseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

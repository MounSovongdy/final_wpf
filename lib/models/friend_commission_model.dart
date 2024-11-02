import 'dart:convert';

class FriendCommissionModel {
  final int id;
  final String year;
  final String month;
  final String name;
  final String tel;
  final String commission;
  final String unitSale;
  final String totalCommission;

  FriendCommissionModel({
    this.id = 0,
    this.year = '',
    this.month = '',
    this.name = '',
    this.tel = '',
    this.commission = '',
    this.unitSale = '',
    this.totalCommission = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'name': name,
      'tel': tel,
      'commission': commission,
      'unit_sale': unitSale,
      'total_commission': totalCommission,
    };
  }

  factory FriendCommissionModel.fromMap(Map<String, dynamic> map) {
    return FriendCommissionModel(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      name: map['name'] as String,
      tel: map['tel'] as String,
      commission: map['commission'] as String,
      unitSale: map['unit_sale'] as String,
      totalCommission: map['total_commission'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendCommissionModel.fromJson(String source) => FriendCommissionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

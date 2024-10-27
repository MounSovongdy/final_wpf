import 'dart:convert';

class CashModel {
  final int id;
  final String date;
  final String saleman;
  final String idCard;
  final String name;
  final String gender;
  final String age;
  final String tel;
  final String address;
  final String brand;
  final String model;
  final String year;
  final String color;
  final String power;
  final String condition;
  final String engineNo;
  final String frameNo;
  final String type;
  final String plateNo;
  final String price;
  final String discount;
  final String totalPrice;
  final String comeBy;
  final String comeByName;
  final String comeByTel;
  final String commission;

  CashModel({
    this.id = 0,
    this.date = '',
    this.saleman = '',
    this.idCard = '',
    this.name = '',
    this.gender = '',
    this.age = '',
    this.tel = '',
    this.address = '',
    this.brand = '',
    this.model = '',
    this.year = '',
    this.color = '',
    this.power = '',
    this.condition = '',
    this.engineNo = '',
    this.frameNo = '',
    this.type = '',
    this.plateNo = '',
    this.price = '',
    this.discount = '',
    this.totalPrice = '',
    this.comeBy = '',
    this.comeByName = '',
    this.comeByTel = '',
    this.commission = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'saleman': saleman,
      'idCard': idCard,
      'name': name,
      'gender': gender,
      'age': age,
      'tel': tel,
      'address': address,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'power': power,
      'condition': condition,
      'engine_no': engineNo,
      'frame_no': frameNo,
      'type': type,
      'plate_no': plateNo,
      'price': price,
      'discount': discount,
      'total_price': totalPrice,
      'come_by': comeBy,
      'come_by_name': comeByName,
      'come_by_tel': comeByTel,
      'commission': commission,
    };
  }

  factory CashModel.fromMap(Map<String, dynamic> map) {
    return CashModel(
      id: map['id'] as int,
      date: map['date'] as String,
      saleman: map['saleman'] as String,
      idCard: map['idCard'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      age: map['age'] as String,
      tel: map['tel'] as String,
      address: map['address'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as String,
      color: map['color'] as String,
      power: map['power'] as String,
      condition: map['condition'] as String,
      engineNo: map['engine_no'] as String,
      frameNo: map['frame_no'] as String,
      type: map['type'] as String,
      plateNo: map['plate_no'] as String,
      price: map['price'] as String,
      discount: map['discount'] as String,
      totalPrice: map['total_price'] as String,
      comeBy: map['come_by'] as String,
      comeByName: map['come_by_name'] as String,
      comeByTel: map['come_by_tel'] as String,
      commission: map['commission'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashModel.fromJson(String source) =>
      CashModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

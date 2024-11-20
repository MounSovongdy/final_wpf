import 'dart:convert';

class LeasingModel {
  final int id;
  final String leasingDate;
  final String leasingYear;
  final String leasingMonth;
  final int bookingId;
  final String idCard;
  final String name;
  final String gender;
  final String age;
  final String tel;
  final String address;
  final String bookingDate;
  final String micro;
  final String saleman;
  final String workingHours;
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
  final String deposit;
  final String remain;
  final String approveAmount;
  final String totalDebt;
  final String comeBy;
  final String comeByName;
  final String comeByTel;
  final String commission;

  LeasingModel({
    this.id = 0,
    this.leasingDate = '',
    this.leasingYear = '',
    this.leasingMonth = '',
    this.bookingId = 0,
    this.idCard = '',
    this.name = '',
    this.gender = '',
    this.age = '',
    this.tel = '',
    this.address = '',
    this.bookingDate = '',
    this.micro = '',
    this.saleman = '',
    this.workingHours = '',
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
    this.deposit = '',
    this.remain = '',
    this.approveAmount = '',
    this.totalDebt = '',
    this.comeBy = '',
    this.comeByName = '',
    this.comeByTel = '',
    this.commission = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'leasing_date': leasingDate,
      'leasing_year': leasingYear,
      'leasing_month': leasingMonth,
      'booking_id': bookingId,
      'id_card': idCard,
      'name': name,
      'gender': gender,
      'age': age,
      'tel': tel,
      'address': address,
      'booking_date': bookingDate,
      'micro': micro,
      'saleman': saleman,
      'working_hours': workingHours,
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
      'deposit': deposit,
      'remain': remain,
      'approve_amount': approveAmount,
      'total_debt': totalDebt,
      'come_by': comeBy,
      'come_by_name': comeByName,
      'come_by_tel': comeByTel,
      'commission': commission,
    };
  }

  factory LeasingModel.fromMap(Map<String, dynamic> map) {
    return LeasingModel(
      id: map['id'] as int,
      leasingDate: map['leasing_date'] as String,
      leasingYear: map['leasing_year'] as String,
      leasingMonth: map['leasing_month'] as String,
      bookingId: map['booking_id'] as int,
      idCard: map['id_card'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      age: map['age'] as String,
      tel: map['tel'] as String,
      address: map['address'] as String,
      bookingDate: map['booking_date'] as String,
      micro: map['micro'] as String,
      saleman: map['saleman'] as String,
      workingHours: map['working_hours'] as String,
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
      deposit: map['deposit'] as String,
      remain: map['remain'] as String,
      approveAmount: map['approve_amount'] as String,
      totalDebt: map['total_debt'] as String,
      comeBy: map['come_by'] as String,
      comeByName: map['come_by_name'] as String,
      comeByTel: map['come_by_tel'] as String,
      commission: map['commission'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeasingModel.fromJson(String source) => LeasingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

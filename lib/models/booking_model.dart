import 'dart:convert';

class BookingModel {
  final int id;
  final String bookingDate;
  final String micro;
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
  final String condition;
  final String price;
  final String discount;
  final String deposit;
  final String remain;
  final String comeBy;
  final String comeByName;
  final String comeByTel;
  final String remark;
  final String statusBooking;
  final String statusDone;
  final String statusDate;
  final String workingHours;

  BookingModel({
    this.id = 0,
    this.bookingDate = '',
    this.micro = '',
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
    this.condition = '',
    this.price = '',
    this.discount = '',
    this.deposit = '',
    this.remain = '',
    this.comeBy = '',
    this.comeByName = '',
    this.comeByTel = '',
    this.remark = '',
    this.statusBooking = '',
    this.statusDone = '',
    this.statusDate = '',
    this.workingHours = '',
  });

  BookingModel copyWith({
    int? id,
    String? bookingDate,
    String? micro,
    String? saleman,
    String? idCard,
    String? name,
    String? gender,
    String? age,
    String? tel,
    String? address,
    String? brand,
    String? model,
    String? year,
    String? color,
    String? condition,
    String? price,
    String? discount,
    String? deposit,
    String? remain,
    String? comeBy,
    String? comeByName,
    String? comeByTel,
    String? remark,
    String? statusBooking,
    String? statusDone,
    String? statusDate,
    String? workingHours,
  }) {
    return BookingModel(
      id: id ?? this.id,
      bookingDate: bookingDate ?? this.bookingDate,
      micro: micro ?? this.micro,
      saleman: saleman ?? this.saleman,
      idCard: idCard ?? this.idCard,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      tel: tel ?? this.tel,
      address: address ?? this.address,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      color: color ?? this.color,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      deposit: deposit ?? this.deposit,
      remain: remain ?? this.remain,
      comeBy: comeBy ?? this.comeBy,
      comeByName: comeByName ?? this.comeByName,
      comeByTel: comeByTel ?? this.comeByTel,
      remark: remark ?? this.remark,
      statusBooking: statusBooking ?? this.statusBooking,
      statusDone: statusDone ?? this.statusDone,
      statusDate: statusDate ?? this.statusDate,
      workingHours: workingHours ?? this.workingHours,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'booking_date': bookingDate,
      'micro': micro,
      'saleman': saleman,
      'id_card': idCard,
      'name': name,
      'gender': gender,
      'age': age,
      'tel': tel,
      'address': address,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'condition': condition,
      'price': price,
      'discount': discount,
      'deposit': deposit,
      'remain': remain,
      'come_by': comeBy,
      'come_by_name': comeByName,
      'come_by_tel': comeByTel,
      'remark': remark,
      'status_booking': statusBooking,
      'status_done': statusDone,
      'status_date': statusDate,
      'working_hours': workingHours,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] as int,
      bookingDate: map['booking_date'] as String,
      micro: map['micro'] as String,
      saleman: map['saleman'] as String,
      idCard: map['id_card'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      age: map['age'] as String,
      tel: map['tel'] as String,
      address: map['address'] as String,
      brand: map['brand'] as String,
      model: map['model'] as String,
      year: map['year'] as String,
      color: map['color'] as String,
      condition: map['condition'] as String,
      price: map['price'] as String,
      discount: map['discount'] as String,
      deposit: map['deposit'] as String,
      remain: map['remain'] as String,
      comeBy: map['come_by'] as String,
      comeByName: map['come_by_name'] as String,
      comeByTel: map['come_by_tel'] as String,
      remark: map['remark'] as String,
      statusBooking: map['status_booking'] as String,
      statusDone: map['status_done'] as String,
      statusDate: map['status_date'] as String,
      workingHours: map['working_hours'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingModel(id: $id, booking_date: $bookingDate, micro: $micro, saleman: $saleman, id_card: $idCard, name: $name, gender: $gender, age: $age, tel: $tel, address: $address, brand: $brand, model: $model, year: $year, color: $color, condition: $condition, price: $price, discount: $discount, deposit: $deposit, remain: $remain, come_by: $comeBy, come_by_name: $comeByName, come_by_tel: $comeByTel, remark: $remark, status_booking: $statusBooking, status_done: $statusDone, status_date: $statusDate, working_hours: $workingHours)';
  }

  @override
  bool operator ==(covariant BookingModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.bookingDate == bookingDate &&
        other.micro == micro &&
        other.saleman == saleman &&
        other.idCard == idCard &&
        other.name == name &&
        other.gender == gender &&
        other.age == age &&
        other.tel == tel &&
        other.address == address &&
        other.brand == brand &&
        other.model == model &&
        other.year == year &&
        other.color == color &&
        other.condition == condition &&
        other.price == price &&
        other.discount == discount &&
        other.deposit == deposit &&
        other.remain == remain &&
        other.comeBy == comeBy &&
        other.comeByName == comeByName &&
        other.comeByTel == comeByTel &&
        other.remark == remark &&
        other.statusBooking == statusBooking &&
        other.statusDone == statusDone &&
        other.statusDate == statusDate &&
        other.workingHours == workingHours;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        bookingDate.hashCode ^
        micro.hashCode ^
        saleman.hashCode ^
        idCard.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        tel.hashCode ^
        address.hashCode ^
        brand.hashCode ^
        model.hashCode ^
        year.hashCode ^
        color.hashCode ^
        condition.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        deposit.hashCode ^
        remain.hashCode ^
        comeBy.hashCode ^
        comeByName.hashCode ^
        comeByTel.hashCode ^
        remark.hashCode ^
        statusBooking.hashCode ^
        statusDone.hashCode ^
        statusDate.hashCode ^ 
        workingHours.hashCode;
  }
}

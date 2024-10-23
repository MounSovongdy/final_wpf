import 'dart:convert';

class BookingMicroModel {
  final int id;
  final String bookingID;
  final String bookingDate;
  final String name;
  final String idCard;
  final String tel;
  final String micro1;
  final String micro2;
  final String statusBooking1;
  final String statusBooking2;
  final String statusDate1;
  final String statusDate2;
  final String workingHours1;
  final String workingHours2;

  BookingMicroModel({
    this.id = 0,
    this.bookingID = '',
    this.bookingDate = '',
    this.name = '',
    this.idCard = '',
    this.tel = '',
    this.micro1 = '',
    this.micro2 = '',
    this.statusBooking1 = '',
    this.statusBooking2 = '',
    this.statusDate1 = '',
    this.statusDate2 = '',
    this.workingHours1 = '',
    this.workingHours2 = '',
  });

  BookingMicroModel copyWith({
    int? id,
    String? bookingID,
    String? bookingDate,
    String? name,
    String? idCard,
    String? tel,
    String? micro1,
    String? micro2,
    String? statusBooking1,
    String? statusBooking2,
    String? statusDate1,
    String? statusDate2,
    String? workingHours1,
    String? workingHours2,
  }) {
    return BookingMicroModel(
      id: id ?? this.id,
      bookingID: bookingID ?? this.bookingID,
      bookingDate: bookingDate ?? this.bookingDate,
      name: name ?? this.name,
      idCard: idCard ?? this.idCard,
      tel: tel ?? this.tel,
      micro1: micro1 ?? this.micro1,
      micro2: micro2 ?? this.micro2,
      statusBooking1: statusBooking1 ?? this.statusBooking1,
      statusBooking2: statusBooking2 ?? this.statusBooking2,
      statusDate1: statusDate1 ?? this.statusDate1,
      statusDate2: statusDate2 ?? this.statusDate2,
      workingHours1: workingHours1 ?? this.workingHours1,
      workingHours2: workingHours2 ?? this.workingHours2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'booking_id': bookingID,
      'booking_date': bookingDate,
      'name': name,
      'id_card': idCard,
      'tel': tel,
      'micro1': micro1,
      'micro2': micro2,
      'status_booking1': statusBooking1,
      'status_booking2': statusBooking2,
      'status_date1': statusDate1,
      'status_date2': statusDate2,
      'working_hours1': workingHours1,
      'working_hours2': workingHours2,
    };
  }

  factory BookingMicroModel.fromMap(Map<String, dynamic> map) {
    return BookingMicroModel(
      id: map['id'] as int,
      bookingID: map['booking_id'] as String,
      bookingDate: map['booking_date'] as String,
      name: map['name'] as String,
      idCard: map['id_card'] as String,
      tel: map['tel'] as String,
      micro1: map['micro1'] as String,
      micro2: map['micro2'] as String,
      statusBooking1: map['status_booking1'] as String,
      statusBooking2: map['status_booking2'] as String,
      statusDate1: map['status_date1'] as String,
      statusDate2: map['status_date2'] as String,
      workingHours1: map['working_hours1'] as String,
      workingHours2: map['working_hours2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingMicroModel.fromJson(String source) => BookingMicroModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingMicroModel(id: $id, booking_id: $bookingID, booking_date: $bookingDate, name: $name, id_card: $idCard, tel: $tel, micro1: $micro1, micro2: $micro2, status_booking1: $statusBooking1, status_booking2: $statusBooking2, status_date1: $statusDate1, status_date2: $statusDate2, working_hours1: $workingHours1, working_hours2: $workingHours2)';
  }

  @override
  bool operator ==(covariant BookingMicroModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.bookingID == bookingID &&
      other.bookingDate == bookingDate &&
      other.name == name &&
      other.idCard == idCard &&
      other.tel == tel &&
      other.micro1 == micro1 &&
      other.micro2 == micro2 &&
      other.statusBooking1 == statusBooking1 &&
      other.statusBooking2 == statusBooking2 &&
      other.statusDate1 == statusDate1 &&
      other.statusDate2 == statusDate2 &&
      other.workingHours1 == workingHours1 &&
      other.workingHours2 == workingHours2;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      bookingID.hashCode ^
      bookingDate.hashCode ^
      name.hashCode ^
      idCard.hashCode ^
      tel.hashCode ^
      micro1.hashCode ^
      micro2.hashCode ^
      statusBooking1.hashCode ^
      statusBooking2.hashCode ^
      statusDate1.hashCode ^
      statusDate2.hashCode ^
      workingHours1.hashCode ^
      workingHours2.hashCode;
  }
}

import 'dart:convert';

class MicroModel {
  final int id;
  final String name;
  final String tel;
  final String email;
  final String tBonus;
  final String contactName;
  final String contactTel;
  final String contactEmail;
  final String contactPosition;

  MicroModel({
    this.id = 0,
    this.name = 'name',
    this.tel = 'tel',
    this.email = 'email',
    this.tBonus = 'tBonus',
    this.contactName = 'contact_name',
    this.contactTel = 'contact_tel',
    this.contactEmail = 'contact_email',
    this.contactPosition = 'contact_position',
  });

  MicroModel copyWith({
    int? id,
    String? name,
    String? tel,
    String? email,
    String? tBonus,
    String? contactName,
    String? contactTel,
    String? contactEmail,
    String? contactPosition,
  }) {
    return MicroModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tel: tel ?? this.tel,
      email: email ?? this.email,
      tBonus: tBonus ?? this.tBonus,
      contactName: contactName ?? this.contactName,
      contactTel: contactTel ?? this.contactTel,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPosition: contactPosition ?? this.contactPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'tel': tel,
      'email': email,
      'tBonus': tBonus,
      'contact_name': contactName,
      'contact_tel': contactTel,
      'contact_email': contactEmail,
      'contact_position': contactPosition,
    };
  }

  factory MicroModel.fromMap(Map<String, dynamic> map) {
    return MicroModel(
      id: map['id'] as int,
      name: map['name'] as String,
      tel: map['tel'] as String,
      email: map['email'] as String,
      tBonus: map['tBonus'] as String,
      contactName: map['contact_name'] as String,
      contactTel: map['contact_tel'] as String,
      contactEmail: map['contact_email'] as String,
      contactPosition: map['contact_position'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MicroModel.fromJson(String source) => MicroModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MicroModel(id: $id, name: $name, tel: $tel, email: $email, tBonus: $tBonus, contact_name: $contactName, contact_tel: $contactTel, contact_email: $contactEmail, contact_position: $contactPosition)';
  }

  @override
  bool operator ==(covariant MicroModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.tel == tel &&
      other.email == email &&
      other.tBonus == tBonus &&
      other.contactName == contactName &&
      other.contactTel == contactTel &&
      other.contactEmail == contactEmail &&
      other.contactPosition == contactPosition;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      tel.hashCode ^
      email.hashCode ^
      tBonus.hashCode ^
      contactName.hashCode ^
      contactTel.hashCode ^
      contactEmail.hashCode ^
      contactPosition.hashCode;
  }
}

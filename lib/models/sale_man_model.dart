import 'dart:convert';

class SaleManModel {
  final int id;
  final String name;
  final String gender;
  final String tel;
  final String position;
  final String salary;
  final String bonus;
  final String date;

  SaleManModel({
    this.id = 0,
    this.name = 'name',
    this.gender = 'gender',
    this.tel = 'tel',
    this.position = 'position',
    this.salary = 'salary',
    this.bonus = 'bonus',
    this.date = 'date',
  });

  SaleManModel copyWith({
    int? id,
    String? name,
    String? gender,
    String? tel,
    String? position,
    String? salary,
    String? bonus,
    String? date,
  }) {
    return SaleManModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      tel: tel ?? this.tel,
      position: position ?? this.position,
      salary: salary ?? this.salary,
      bonus: bonus ?? this.bonus,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'gender': gender,
      'tel': tel,
      'position': position,
      'salary': salary,
      'bonus': bonus,
      'date': date,
    };
  }

  factory SaleManModel.fromMap(Map<String, dynamic> map) {
    return SaleManModel(
      id: map['id'] as int,
      name: map['name'] as String,
      gender: map['gender'] as String,
      tel: map['tel'] as String,
      position: map['position'] as String,
      salary: map['salary'] as String,
      bonus: map['bonus'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SaleManModel.fromJson(String source) => SaleManModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SaleModel(id: $id, name: $name, gender: $gender, tel: $tel, position: $position, salary: $salary, bonus: $bonus, date: $date)';
  }

  @override
  bool operator ==(covariant SaleManModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.gender == gender &&
      other.tel == tel &&
      other.position == position &&
      other.salary == salary &&
      other.bonus == bonus &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      gender.hashCode ^
      tel.hashCode ^
      position.hashCode ^
      salary.hashCode ^
      bonus.hashCode ^
      date.hashCode;
  }
}

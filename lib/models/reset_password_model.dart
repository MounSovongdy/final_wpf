import 'dart:convert';

class ResetPasswordModel {
  final int id;
  final String date;
  final String name;
  final String user;
  final String resetBy;

  ResetPasswordModel({
    required this.id,
    required this.date,
    required this.name,
    required this.user,
    required this.resetBy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'name': name,
      'user': user,
      'reset_by': resetBy,
    };
  }

  factory ResetPasswordModel.fromMap(Map<String, dynamic> map) {
    return ResetPasswordModel(
      id: map['id'] as int,
      date: map['date'] as String,
      name: map['name'] as String,
      user: map['user'] as String,
      resetBy: map['reset_by'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResetPasswordModel.fromJson(String source) => ResetPasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String role;
  final String user;
  final String dateCreate;
  final String password;
  final String status;

  UserModel({
    this.id = 0,
    this.name = 'name',
    this.role = 'role',
    this.user = 'user',
    this.password = 'password',
    this.dateCreate = 'date_create',
    this.status = 'status',
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? role,
    String? user,
    String? password,
    String? dateCreate,
    String? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      user: user ?? this.user,
      password: password ?? this.password,
      dateCreate: dateCreate ?? this.dateCreate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'user': user,
      'password': password,
      'date_create': dateCreate,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      role: map['role'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      dateCreate: map['date_create'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, role: $role, user: $user, password: $password, date_create: $dateCreate, status: $status)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.user == user &&
        other.password == password &&
        other.dateCreate == dateCreate && 
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        user.hashCode ^
        password.hashCode ^
        dateCreate.hashCode ^
        status.hashCode;
  }
}

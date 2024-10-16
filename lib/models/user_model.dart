import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String role;
  final String user;
  final String password;
  
  UserModel({
    this.id = 'id',
    this.name = 'name',
    this.role = 'role',
    this.user = 'user',
    this.password = 'password',
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? role,
    String? user,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'user': user,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      role: map['role'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, role: $role, user: $user, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.role == role &&
      other.user == user &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      role.hashCode ^
      user.hashCode ^
      password.hashCode;
  }
}

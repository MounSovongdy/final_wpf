import 'dart:convert';

class AddressModel {
  final int id;
  final String address;
  
  AddressModel({
    required this.id,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

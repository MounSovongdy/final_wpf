import 'dart:convert';

class ColorModel {
  final int id;
  final String color;
  
  ColorModel({
    required this.id,
    required this.color,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      id: map['id'] as int,
      color: map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) => ColorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

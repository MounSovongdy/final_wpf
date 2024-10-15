import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';

class UnderLine extends StatelessWidget {
  final Color color;
  final double height, width;

  const UnderLine({
    super.key,
    this.color = whiteColor,
    this.height = 1,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: width,
    );
  }
}

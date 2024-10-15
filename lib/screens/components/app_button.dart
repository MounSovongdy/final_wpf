import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppButton extends StatelessWidget {
  final String txt;
  final double width;
  final Color color;
  final Function()? tap;

  const AppButton({
    super.key,
    required this.txt,
    this.width = 150,
    this.color = bgColor,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.px,
      width: width.px,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: tap,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        child: Center(
          child: AppText.title(context, txt: txt, color: whiteColor),
        ),
      ),
    );
  }
}

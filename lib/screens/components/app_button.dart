import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppButtonSubmit extends StatelessWidget {
  final String txt;
  final double width;
  final Color color;
  final Function()? tap;

  const AppButtonSubmit({
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

class AppButtonCalulation extends StatelessWidget {
  final String txt;
  final Widget? suffix;
  final double width, height;
  final int flex;
  final TextInputType txtInput;
  final Function()? tap;

  const AppButtonCalulation({
    super.key,
    required this.txt,
    this.suffix,
    this.width = 150,
    this.height = 40,
    this.flex = 2,
    this.txtInput = TextInputType.text,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 20.px),
            child: AppText.title(context, txt: txt, textAlign: TextAlign.right,color: whiteColor),
          ),
        ),
        Expanded(
          flex: flex,
          child: SizedBox(
            width: width.px,
            height: height.px,
            child: InkWell(
              onTap: tap,
              child: Container(
                height: 40.px,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: bgColor,
                ),
                child: Center(
                  child: AppText.title(context, txt: txt, color: whiteColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

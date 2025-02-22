import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextField extends StatelessWidget {
  final String txt;
  final TextEditingController con;
  final bool readOnly, obscureText, showSuffixIcon;
  final Widget? suffix;
  final double width, height;
  final int flex;
  final bool isNumber;
  final int digit;
  final TextInputType txtInput;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.txt,
    required this.con,
    this.readOnly = false,
    this.obscureText = false,
    this.showSuffixIcon = false,
    this.suffix,
    this.width = 150,
    this.height = 40,
    this.flex = 2,
    this.isNumber = false,
    this.digit = 4,
    this.txtInput = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.only(right: 20.px),
            child: AppText.title(context, txt: txt, textAlign: TextAlign.right),
          ),
        ),
        Expanded(
          flex: flex,
          child: Container(
            width: width.px,
            height: height.px,
            color: readOnly ? secondGreyColor.withOpacity(0.5) : noneColor,
            child: TextField(
              controller: con,
              obscureText: obscureText,
              onChanged: onChanged,
              readOnly: readOnly,
              keyboardType: isNumber ? TextInputType.number : txtInput,
              inputFormatters: isNumber
                  ? [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                      LengthLimitingTextInputFormatter(digit),
                    ]
                  : [],
              style: TextStyle(
                color: blackColor,
                fontSize: Responsive.isDesktop(context) ? 16.px : 16.px - 2,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: defWebPad.px),
                suffixIcon: showSuffixIcon ? suffix : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppTextFieldLogin extends StatelessWidget {
  final String txt; // Label text
  final TextEditingController con; // Controller for input
  final bool obscureText; // Whether the text is obscured (for passwords)
  final Widget? suffix; // Custom suffix widget (like an icon)
  final bool showSuffixIcon; // Whether to show the suffix icon
  final int flex; // Responsiveness factor

  const AppTextFieldLogin({
    super.key,
    required this.txt,
    required this.con,
    this.obscureText = false,
    this.suffix,
    this.showSuffixIcon = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: con,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: txt,
        labelStyle: const TextStyle(color: bgColor, fontSize: 14),
        filled: true,
        fillColor: whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: bgColor),
        ),
        suffixIcon: showSuffixIcon ? suffix : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

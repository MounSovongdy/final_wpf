import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppDateTextField extends StatelessWidget {
  final String txt;
  final TextEditingController con;
  final bool readOnly, obscureText, showSuffixIcon;
  final double width, height;
  final int flex;

  const AppDateTextField({
    super.key,
    required this.txt,
    required this.con,
    this.readOnly = false,
    this.obscureText = false,
    this.showSuffixIcon = false,
    this.width = 150,
    this.height = 40,
    this.flex = 2,
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
              readOnly: readOnly,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2033),
                );
                if (picked != null) {
                  con.text = "${picked.toLocal()}".split(' ')[0];
                }
              },
              style: TextStyle(
                color: blackColor,
                fontSize: Responsive.isDesktop(context) ? 16.px : 16.px - 2,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.ellipsis,
              ),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: defWebPad.px),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: defWebPad.px),
                  child: const Icon(Icons.today),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TotalExpenseScreen extends StatelessWidget {
  const TotalExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: Responsive.isDesktop(context) ? defWebPad : defMobPad,
      width: Responsive.isDesktop(context) ? defWebPad : defMobPad,
    );
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.all(defWebPad.px),
          padding: EdgeInsets.all(defWebPad.px),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(defRadius.px),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.header(context, txt: 'Total Expenses'),
              spacer,
            ],
          )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SaleRecordScreen extends StatelessWidget {
  SaleRecordScreen({super.key});

  final con = Get.put(MainController());

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
            AppText.header(context, txt: 'Sale Record'),
            spacer,
          ],
        ),
      ),
    );
  }
}

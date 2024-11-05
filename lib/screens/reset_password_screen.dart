import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/reset_password_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_date_text_field.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final con = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: con.title.value),
            spacer(context),
            RowTextField(
              spacer: spacer(context),
              widget1: AppDateTextField(
                txt: 'Date',
                con: con.date.value,
              ),
              widget2: AppDropdownSearch(
                txt: 'Full Name',
                value: con.fullName,
                list: con.fullNameList,
                onChanged: (v) {
                  if (v != null) {
                    con.fullName.value = v;
                  }
                },
              ),
              widget3: AppTextField(
                txt: 'Username',
                con: con.name.value,
                readOnly: true,
              ),
            ),
            spacer(context),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButtonSubmit(
                  txt: 'Reset',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

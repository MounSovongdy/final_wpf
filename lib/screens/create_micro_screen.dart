import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_micro_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateMicroScreen extends StatelessWidget {
  CreateMicroScreen({super.key});
  final con = Get.put(CreateMicroController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(defWebPad.px),
        padding: EdgeInsets.all(defWebPad.px),
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defRadius.px),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.header(context, txt: 'Create Micro'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'Institution Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Name', con: con.nameInstitution.value),
              widget2: AppTextField(txt: 'Tel', con: con.tel.value),
              widget3: AppTextField(txt: 'Email', con: con.email.value),
            ),
            TitleUnderline(spacer: spacer(context), txt: 'Contact Person Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Name', con: con.nameContact.value),
              widget2: AppTextField(txt: 'Tel', con: con.telContact.value),
              widget3: AppTextField(txt: 'Email', con: con.emailContact.value),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Position', con: con.position.value),
            ),
            spacer(context),
            spacer(context),
            spacer(context),
            const UnderLine(color: secondGreyColor),
            spacer(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppButton(
                  txt: 'Cancel',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () {},
                ),
                spacer(context),
                spacer(context),
                AppButton(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/controllers/create_user_controller.dart';
import 'package:motor/screens/components/app_dropdown.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({super.key});

  final con = Get.put(CreateUserController());

  final role = ['Super Admin', 'Admin', 'Sale'];

  @override
  Widget build(BuildContext context) {
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
            AppText.header(context, txt: 'Create User'),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'User Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Name', con: con.fullName.value),
              widget2: AppTextField(txt: 'Tel', con: con.tel.value),
              widget3: AppDropdown(
                txt: 'Role',
                value: con.role,
                list: role,
                onChanged: (v) {
                  if (v != null) con.role = v;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

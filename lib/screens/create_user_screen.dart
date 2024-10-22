import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_user_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/user_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_dropdown_search.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({super.key});

  final con = Get.put(CreateUserController());
  final conU = Get.put(UserController());
  final conMain = Get.put(MainController());

  final role = ['Super Admin', 'Admin', 'User'];

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
            AppText.header(context, txt: conU.title.value),
            spacer(context),
            TitleUnderline(spacer: spacer(context), txt: 'User Information'),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(txt: 'Full Name', con: con.name.value),
              widget2: AppDropdownSearch(
                txt: 'Role Level',
                value: con.role,
                list: role,
                onChanged: (v) {
                  if (v != null) con.role.value = v;
                },
              ),
              widget3: AppTextField(
                txt: 'User Login',
                con: con.userLogin.value,
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
                AppButton(
                  txt: 'Back',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    con.clearText();
                    await getAllUser();
                    conU.filteredUsers.value = user;
                    conU.search.value.addListener(conU.filterUserData);

                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButton(
                  txt: 'Save',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    if (conU.title.value == 'Create User') {
                      con.createUser(context);
                    } else {
                      con.updateUser(context);
                    }
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

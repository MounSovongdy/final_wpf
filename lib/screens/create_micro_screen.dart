import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor/constants/constants.dart';
import 'package:motor/constants/firebase.dart';
import 'package:motor/constants/responsive.dart';
import 'package:motor/controllers/create_micro_controller.dart';
import 'package:motor/controllers/main_controller.dart';
import 'package:motor/controllers/micro_controller.dart';
import 'package:motor/screens/components/app_button.dart';
import 'package:motor/screens/components/app_text_field.dart';
import 'package:motor/screens/components/row_text_field.dart';
import 'package:motor/screens/components/title_underline.dart';
import 'package:motor/screens/components/under_line.dart';
import 'package:motor/screens/widgets/app_text.dart';
import 'package:motor/screens/widgets/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateMicroScreen extends StatelessWidget {
  CreateMicroScreen({super.key});

  final con = Get.put(CreateMicroController());
  final conMi = Get.put(MicroController());
  final conMain = Get.put(MainController());

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
            AppText.header(context, txt: conMi.title.value),
            spacer(context),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Institution Information | ព័ត៌មានស្ថាប័ន',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.nameInstitution.value,
              ),
              widget2: AppTextField(
                txt: 'Tel | លេខទូរស័ព្ទ',
                con: con.tel.value,
                isNumber: true,
                digit: 10,
              ),
              widget3: AppTextField(
                txt: 'Email | អ៊ីម៉ែល',
                con: con.email.value,
              ),
            ),
            TitleUnderline(
              spacer: spacer(context),
              txt: 'Contact Person Information | ព័ត៌មានអ្នកទំនាក់ទំនង',
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Name | ឈ្មោះ',
                con: con.nameContact.value,
              ),
              widget2: AppTextField(
                txt: 'Tel | លេខទូរស័ព្ទ',
                con: con.telContact.value,
                isNumber: true,
                digit: 10,
              ),
              widget3: AppTextField(
                txt: 'Email | អ៊ីម៉ែល',
                con: con.emailContact.value,
              ),
            ),
            RowTextField(
              spacer: spacer(context),
              widget1: AppTextField(
                txt: 'Position | តួនាទី',
                con: con.positionContact.value,
              ),
              widget2: AppTextField(
                txt: 'Bonus | ប្រាក់រង្វាន់',
                con: con.tBonus.value,
                isNumber: true,
                digit: 5,
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
                  txt: 'Back | ត្រលប់ក្រោយ',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  color: secondGreyColor,
                  tap: () async {
                    startInactivityTimer();
                    LoadingWidget.dialogLoading(duration: 1, isBack: true);
                    con.clearText();
                    await getAllMicro();
                    conMi.filteredMicro.value = micro;
                    conMi.search.value.addListener(conMi.filterMicroData);
                    Get.back();
                    conMain.index.value = conMain.index.value - 1;
                  },
                ),
                spacer(context),
                spacer(context),
                AppButtonSubmit(
                  txt: 'Save | រក្សាទុក',
                  width: Responsive.isDesktop(context) ? 150.px : 100.px,
                  tap: () {
                    startInactivityTimer();
                    if (conMi.title.value == 'Create Micro') {
                      con.createMicro(context);
                    } else {
                      con.updateMicro(context);
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
